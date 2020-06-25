import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/utils/storeData.dart';

// There is a fetch limit when querying from Firestore.
const int FETCH_LIMIT = 20;

class Test {
  final db;

  /// Test constructor.
  Test() : this.db = Firestore.instance;

  /// Define test methods here. Uncomment the functions you want to execute.
  void testMethods() async {
    // Get random recipe
    List<Recipe> recipes = getRecipes();

    // Add a new user to database. Uncomment to test.
    //testAddUser("tempUser", 0, RankType.beginner);
    //print("Creating user document...");

    // Add a new recipe to database. Uncomment to test.
    //testAddRecipe(recipes[1]);
    //print("Creating new recipe...");

    // Get recipe object from title.
    //Recipe fetchedRecipe = await getRecipeFromTitle("Carpaccio van komkommer met geitenkaas");
    // Print a summary of fetched recipe.
    //fetchedRecipe.printSummary();

    // Get vegetarian recipes from Firestore.
    List<Recipe> vegetarianRecipes = await getVegetarianRecipes();
    // Print summary of all vegetarian recipes.
    for (int i = 0; i < vegetarianRecipes.length; i++){
      vegetarianRecipes[i].printSummary();
    }
  }

  /// Add a new user to Firestore database.
  Future<void> testAddUser(String name, int score, RankType type) {
    // Print new user document ID to console.
    this.db.collection("users").add(
        {
          "name": name,
          "rank": type.index,
          "score": score,
        }).then((value) {
      print("Created new user with ID " + value.documentID);
    });
  }

  /// Add a new recipe to Firestore database.
  Future<void> testAddRecipe(Recipe recipe) {
    // Make map with recipe information.
    Map recipeMap = new HashMap<String, Object>();
    recipeMap.putIfAbsent("title", () => recipe.getTitle());
    recipeMap.putIfAbsent("description", () => recipe.getDescription());
    recipeMap.putIfAbsent("type", () =>
    recipe
        .getType()
        .index);
    recipeMap.putIfAbsent("isVegetarian", () => recipe.getIsVegetarian());
    recipeMap.putIfAbsent("duration", () => recipe.getDuration());
    recipeMap.putIfAbsent("ingredients", () => recipe.getIngredients());
    recipeMap.putIfAbsent("imageURL", () => recipe.getImageURL());

    // Print new recipe document ID to console.
    this.db.collection("recipes").add(recipeMap).then((value) {
      print("Created new recipe with ID " + value.documentID);
    });
  }

  /// Return recipe object when supplying it with a title.
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

  /// Last test method. Get all vegetarian recipes from Firestore.
  Future<List<Recipe>> getVegetarianRecipes() async {
    List<Recipe> fetchedRecipes=
    await this.db.collection("recipes")
        .where("isVegetarian", isEqualTo: true)
        .getDocuments()
        //.limit(FETCH_LIMIT)
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