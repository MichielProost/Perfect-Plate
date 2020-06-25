import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/recipe.dart';

/// Firestore services involving recipes.
class RecipeService{
  final db;

  /// Constructor.
  RecipeService() : this.db = Firestore.instance;

  /// Add new recipe to Firestore database.
  Future<void> addRecipe(Recipe recipe){
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

    // Print new recipe document ID to console.
    this.db.collection("recipes").add(recipeMap).then((value) {
      print("Created new recipe with ID " + value.documentID);
    });
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
}