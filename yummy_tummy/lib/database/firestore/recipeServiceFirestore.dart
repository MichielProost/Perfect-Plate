import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/buffer/User_content_buffer.dart';
import 'package:yummytummy/database/firestore/reviewServiceFirestore.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/query/queryInfo.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/storage/storageHandler.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
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

  /// Add a new [Recipe] to the database. Returns the document ID.
  Future<String> addRecipe(Recipe recipe) async {

    // Create a new recipe document.
    String documentID =
    await this.db.collection("recipes")
        .add(recipe.toMap())
        .then((value) {
      return value.documentID;
    });

    // TODO Make sure all fields are present in recipe (including ID)
    // Add the newly created recipe to cache
    UserContentBuffer.instance.addRecipe( recipe );

    consoleWriter.CreatedDocument(CollectionType.Recipe, documentID);
    return documentID;

  }

  /// Delete a [Recipe] from the database when given a document ID [recipeID].
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

    // TODO Make sure all fields are present in recipe (including ID)
    // Remove the deleted recipe from cache
    UserContentBuffer.instance.removeRecipe( recipe );

  }

  /// Returns [Recipe] object from document ID [recipeID].
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

  /// Modify an existing [Recipe] with a given document ID [recipeID].
  Future<void> modifyRecipe(Recipe recipe, String recipeID) async {

    await this.db.collection("recipes")
        .document(recipeID)
        .updateData(
      recipe.toMap()
    );

    consoleWriter.ModifiedDocument(CollectionType.Recipe, recipeID);

  }

  /// Returns a list of [Recipe] objects that match this exact title.
  /// Never returns null, but can return an empty list if no matches are found.
  Future<List<Recipe>> getRecipesFromTitle(String title) async {

    List<Recipe> fetchedRecipes =
    await this.db.collection("recipes")
        .where("title", isEqualTo: title)
        .getDocuments()
        .then((QuerySnapshot docs) {
          
          List<Recipe> recipes = List<Recipe>(docs.documents.length);
          for (int i = 0; i < docs.documents.length; i ++)
          {
            DocumentSnapshot snap = docs.documents[i];
            recipes[i] = Recipe.fromMap(docs.documents[i].data, docs.documents[i].documentID);

            consoleWriter.FetchedDocument(CollectionType.Recipe, snap.documentID);
          }
      return recipes ?? List<Recipe>();
    });

    return fetchedRecipes;

  }

  /// Returns all recipes made by a specific user.
  /// [field] : Specify user by name or id.
  /// [value] : Value of the field.
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

  /// Returns all [Recipe] objects in the user's favourite list.
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

  /// Returns all vegetarian [Recipe] objects.
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
  /// [QueryInfo] : Info of a particular query.
  /// [SortField] : Sort the acquired recipes.
  /// [dietField] : Desired diet of recipes. Should be [DietField.any] when all diets are allowed.
  /// [typeField] : Desired type of recipes. Should be [RecipeType.any] when all types are allowed.
  /// [ingredients] : The ingredients that the recipes should contain. Should be an empty string if all recipes are allowed.
  /// [language] : Desired language of recipes.
  Future<RecipeQuery> searchRecipes(RecipeQuery info, SortField sortField, DietField dietField, RecipeType typeField, List<String> ingredients, {LanguagePick language : LanguagePick.other}) async {

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
    if (language != LanguagePick.other){
      query = query.where("language", isEqualTo: language.index);
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
      if (!info.documentIDs.contains(recipe.id)){
        info.documentIDs.add(recipe.id);
        info.recipes.add(recipe);
      }
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

  /// Update ratings (average and weighted) in [Recipe] document.
  /// [review] : A new review to a particular recipe.
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