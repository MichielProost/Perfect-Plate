import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';

/// Firestore services involving recipes.
class RecipeServiceFirestore implements RecipeService{
  final db;

  /// Constructor.
  RecipeServiceFirestore() : this.db = Firestore.instance;

  /// Add new recipe to database. Return Document ID.
  Future<String> addRecipe(Recipe recipe) async {
    // Make map with recipe information.
    Map recipeMap = new HashMap<String, Object>();
    recipeMap.putIfAbsent("title", () => recipe.title);
    recipeMap.putIfAbsent("description", () => recipe.description);
    recipeMap.putIfAbsent("type", () => recipe.type.index);
    recipeMap.putIfAbsent("isVegetarian", () => recipe.isVegetarian);
    recipeMap.putIfAbsent("ingredients", () => recipe.ingredients);
    recipeMap.putIfAbsent("stepDescriptions", () => recipe.stepDescriptions);
    recipeMap.putIfAbsent("stepImages", () => recipe.stepImages);
    recipeMap.putIfAbsent("rating", () => recipe.rating);
    recipeMap.putIfAbsent("duration", () => recipe.duration);
    recipeMap.putIfAbsent("image", () => recipe.image);
    recipeMap.putIfAbsent("numberOfReviews", () => recipe.numberOfReviews);
    recipeMap.putIfAbsent("userMap", () => recipe.userMap);

    // Add recipe to database and return document ID.
    String documentID =
    await this.db.collection("recipes")
        .add(recipeMap)
        .then((value) {
      return value.documentID;
    });
    return documentID;
  }

  /// Returns recipe object with given title.
  Future<Recipe> getRecipeFromTitle(String title) async {
    Recipe fetchedRecipe =
    await this.db.collection("recipes")
        .where("title", isEqualTo: title)
        .getDocuments()
        .then((QuerySnapshot docs) {
      return docs.documents.isNotEmpty ? Recipe.fromMap(
          docs.documents[0].data, docs.documents[0].documentID) : null;
    });
    return fetchedRecipe;
  }

  /// Get a list of recipes created by a user.
  /// Specify field of UserMap ("id" or "name")
  /// Specify value of field.
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
          }
      return docs.documents.isNotEmpty ? recipes : null;
    });
    return fetchedRecipes;
  }

  /// Get a list of vegetarian recipes (no limit yet).
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
      }
      return docs.documents.isNotEmpty ? recipes : null;
    });
    return fetchedRecipes;
  }
}