import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/utils/consoleWriter.dart';

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

    // Create map from specified recipe object.
    Map recipeMap = new HashMap<String, Object>();
    recipeMap.putIfAbsent("title", () => recipe.title);
    recipeMap.putIfAbsent("description", () => recipe.description);
    recipeMap.putIfAbsent("type", () => recipe.type.index);
    recipeMap.putIfAbsent("isVegetarian", () => recipe.isVegetarian);
    recipeMap.putIfAbsent("isVegan", () => recipe.isVegan);
    recipeMap.putIfAbsent("ingredients", () => recipe.ingredients);
    recipeMap.putIfAbsent("stepDescriptions", () => recipe.stepDescriptions);
    recipeMap.putIfAbsent("stepImages", () => recipe.stepImages);
    recipeMap.putIfAbsent("rating", () => recipe.rating);
    recipeMap.putIfAbsent("duration", () => recipe.duration);
    recipeMap.putIfAbsent("image", () => recipe.image);
    recipeMap.putIfAbsent("numberOfReviews", () => recipe.numberOfReviews);
    recipeMap.putIfAbsent("userMap", () => recipe.userMap);

    // Create a new recipe document.
    String documentID =
    await this.db.collection("recipes")
        .add(recipeMap)
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

  /// Returns all vegetarian recipes.
  Future<List<Recipe>> getVegetarianRecipes() async {

    List<Recipe> fetchedRecipes=
    await this.db.collection("recipes")
        .where("isVegetarian", isEqualTo: true)
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

}