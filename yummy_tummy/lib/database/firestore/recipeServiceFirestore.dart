import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/queryInfo.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/utils/consoleWriter.dart';

const documentLimit = 3;

/// Firestore specific recipe services.
class RecipeServiceFirestore implements RecipeService {

  final db;
  final ConsoleWriter consoleWriter;

  /// Constructor.
  RecipeServiceFirestore() :
        this.db = Firestore.instance,
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

    this.db.collection("recipes")
        .document(recipeID)
        .delete();

    consoleWriter.DeletedDocument(CollectionType.Recipe, recipeID);

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
      return docs.documents.isNotEmpty ? recipes : null;
    });
    return fetchedRecipes;

  }

  /// Returns all recipes in the user's favourite list.
  Future<List<Recipe>> getFavouriteRecipes(User user) async {

    List<Recipe> recipes = new List(user.favourites.length);
    Recipe recipe;
    for( int i=0; i<user.favourites.length; i++){
      recipe = await getRecipeFromID(user.favourites[i]);
      recipes[i] = recipe;
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
  Future<RecipeQuery> searchRecipes(RecipeQuery info, SortField sortField) async {

    // Check if we can fetch documents.
    if(!info.hasMore) {
      print("ERROR: No More Documents");
      return info;
    }

    // Retrieve the appropriate documents from Firestore.
    QuerySnapshot docs;
    if (info.lastDocument == null){
      docs =
          await this.db.collection("recipes")
          .orderBy(sortField.toString().split(".").last, descending: true)
          .limit(documentLimit)
          .getDocuments();
    } else {
      docs =
          await this.db.collection("recipes")
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

  /// TEMPORARY: UI will use this method instead.
  /// Replace by searchRecipes when implementation is done.
  Future<List<Recipe>> searchRecipesUI(RecipeQuery info, SortField sortField){
    //Made to avoid errors.
  }

}