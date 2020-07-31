import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:yummytummy/database/firestore/reviewServiceFirestore.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/query/queryInfo.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/storage/storageHandler.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/utils/calculateRatings.dart';
import 'package:yummytummy/utils/consoleWriter.dart';

const documentLimit = 5;

/// Firestore specific recipe services.
class RecipeServiceFirestore implements RecipeService {

  final db;
  final StorageHandler storageHandler;
  final ConsoleWriter consoleWriter;

  /// Constructor.
  RecipeServiceFirestore() :
        this.db = Firestore.instance,
        this.storageHandler = new StorageHandler(),
        this.consoleWriter = new ConsoleWriter();

  /// Add a new recipe to the database. Returns the document ID.
  Future<String> addRecipe(Recipe recipe) async {

    // Create a new recipe document.
    String documentID =
    await this.db.collection("recipes")
        .add(recipe.toMap())
        .then((value) {
      return value.documentID;
    });

    consoleWriter.CreatedDocument(CollectionType.Recipe, documentID);
    return documentID;

  }

  /// Delete a recipe from the database when given a document ID.
  Future<void> deleteRecipe(String recipeID) async {

    // Get recipe object from ID.
    Recipe recipe = await getRecipeFromID(recipeID);

    // Delete recipe document in database.
    await this.db.collection("recipes")
        .document(recipeID)
        .delete();

    consoleWriter.DeletedDocument(CollectionType.Recipe, recipeID);

    // Delete recipe images in Firebase storage.
    storageHandler.deleteRecipeImages(recipe);

    // Make review service.
    ReviewServiceFirestore reviewService = new ReviewServiceFirestore();

    // Get recipe reviews.
    List<Review> reviews = await reviewService.getReviewsFromRecipe(recipeID);

    // Delete recipe reviews.
    for (int i = 0; i < reviews.length; i++){
      await reviewService.deleteReview(reviews[i].id);
    }

  }

  /// Returns recipe object from document ID.
  Future<Recipe> getRecipeFromID(String recipeID) async {

    Recipe recipe =
    await this.db.collection("recipes")
        .document(recipeID)
        .get()
        .then((DocumentSnapshot snapshot){
      consoleWriter.FetchedDocument(CollectionType.Recipe, snapshot.documentID);
      return snapshot.exists ?
          Recipe.fromMap(snapshot.data, snapshot.documentID) : null;
    });

    return recipe;

  }

  /// Modify an existing recipe with a given document ID.
  Future<void> modifyRecipe(Recipe recipe, String recipeID) async {

    await this.db.collection("recipes")
        .document(recipeID)
        .updateData(
      recipe.toMap()
    );

    consoleWriter.ModifiedDocument(CollectionType.Recipe, recipeID);

  }

  /// Returns recipe object with a given title.
  Future<Recipe> getRecipeFromTitle(String title) async {

    Recipe fetchedRecipe =
    await this.db.collection("recipes")
        .where("title", isEqualTo: title)
        .getDocuments()
        .then((QuerySnapshot docs) {
      return docs.documents.isNotEmpty ? Recipe.fromMap(
          docs.documents[0].data, docs.documents[0].documentID) : null;
    });

    consoleWriter.FetchedDocument(CollectionType.Recipe, fetchedRecipe.id);
    return fetchedRecipe;

  }

  /// Returns all recipes made by a specific user.
  /// Field: Specify user by name or id.
  /// Value: Value of the field.
  Future<List<Recipe>> getRecipesFromUser(UserMapField field, String value) async {

    List<Recipe> fetchedRecipes=
    await this.db.collection("recipes")
        .where("userMap." + field.toString().split(".").last, isEqualTo: value)
        .getDocuments()
        .then((QuerySnapshot docs){
          Recipe recipe;
          List<Recipe> recipes = new List(docs.documents.length);
          for (int i = 0; i < docs.documents.length; i++){
            recipe = Recipe.fromMap(docs.documents[i].data, docs.documents[i].documentID);
            recipes[i] = recipe;
            consoleWriter.FetchedDocument(CollectionType.Recipe, recipe.id);
          }
      return docs.documents.isNotEmpty ? recipes : List<Recipe>();
    });
    return fetchedRecipes;

  }

  /// Returns all recipes in the user's favourite list.
  Future<List<Recipe>> getFavouriteRecipes(User user) async {

    List<String> toDeleteFav = new List<String>();

    List<Recipe> recipes = new List<Recipe>();
    Recipe recipe;
    for( int i=0; i<user.favourites.length; i++){
      recipe = await getRecipeFromID(user.favourites[i]);
      if (recipe != null){
        recipes.add(recipe);
      } else {
        toDeleteFav.add(user.favourites[i]);
      }
    }

    if (toDeleteFav.length > 0){
      for (int i=0; i<toDeleteFav.length; i++){
        user.favourites.remove(toDeleteFav[i]);
      }
      UserServiceFirestore userService = new UserServiceFirestore();
      await userService.modifyUser(user, user.id);
    }

    return recipes;
  }

  /// Returns all vegetarian recipes.
  Future<List<Recipe>> getVegetarianRecipes(SortField sortField) async {

    List<Recipe> fetchedRecipes=
    await this.db.collection("recipes")
        .where("isVegetarian", isEqualTo: false)
        .orderBy(sortField.toString().split(".").last, descending: true)
        .limit(documentLimit)
        .getDocuments()
        .then((QuerySnapshot docs){
      Recipe recipe;
      List<Recipe> recipes = new List(docs.documents.length);
      for (int i = 0; i < docs.documents.length; i++){
        recipe = Recipe.fromMap(docs.documents[i].data, docs.documents[i].documentID);
        recipes[i] = recipe;
        consoleWriter.FetchedDocument(CollectionType.Recipe, recipe.id);
      }
      return docs.documents.isNotEmpty ? recipes : null;
    });
    return fetchedRecipes;

  }

  /// Search recipes in the database by specifying fields.
  /// RecipeQuery: Info of a particular query.
  /// SortField: Sort the acquired recipes.
  Future<RecipeQuery> searchRecipes(RecipeQuery info, SortField sortField, DietField dietField, RecipeType typeField, List<String> ingredients) async {

    // Check if we can fetch documents.
    if(!info.hasMore) {
      print("ERROR: No More Documents");
      return info;
    }

    // Expand query with possible fields.
    Query query = this.db.collection("recipes");
    if (dietField != DietField.any){
      query = query.where("is" + dietField.getString(), isEqualTo: true);
    }
    if (typeField != RecipeType.any){
      query = query.where("type", isEqualTo: typeField.index);
    }

    // Ingredients
    if (ingredients.isNotEmpty){
      query = query.where("ingredients", arrayContainsAny: ingredients);
    }

    // Retrieve the appropriate documents from Firestore.
    QuerySnapshot docs;
    if (info.lastDocument == null){
      docs =
          await query
          .orderBy(sortField.toString().split(".").last, descending: true)
          .limit(documentLimit)
          .getDocuments();
    } else {
      docs =
          await query
          .orderBy(sortField.toString().split(".").last, descending: true)
          .startAfterDocument(info.lastDocument)
          .limit(documentLimit)
          .getDocuments();
    }

    // Add recipes to RecipeQuery object.
    Recipe recipe;
    for (int i = 0; i < docs.documents.length; i++){
      recipe = Recipe.fromMap(docs.documents[i].data, docs.documents[i].documentID);
      info.recipes.add(recipe);
      consoleWriter.FetchedDocument(CollectionType.Recipe, recipe.id);
    }

    // Update hasMore propriety.
    if (docs.documents.length < documentLimit) {
      info.hasMore = false;
    } else {
      // Update lastDocument property.
      info.lastDocument = docs.documents[docs.documents.length - 1];
    }

    // Return RecipeQuery object.
    return info;

  }

  /// Update average and weighted rating in recipe document.
  Future<void> updateRatings(Review review) async {

    // Get recipe object from ID.
    Recipe recipe = await getRecipeFromID(review.recipeID);

    // Update average rating.
    recipe.rating =
        calculateAverageRating(recipe.rating, review.rating, recipe.numberOfReviews);

    // Update weighted rating.
    recipe.weightedRating =
        calculateWeightedRating(recipe.rating, recipe.numberOfReviews);

    // Update number of reviews after updating ratings.
    recipe.numberOfReviews++;

    // Modify recipe document with new fields.
    await modifyRecipe(recipe, review.recipeID);

  }

}