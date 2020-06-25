import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/utils/storeData.dart';

class Test{
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
    Recipe fetchedRecipe = await getRecipeFromTitle("Carpaccio van komkommer met geitenkaas");
    // Print a summary of fetched recipe.
    fetchedRecipe.printSummary();
  }

  /// Add a new user to Firestore database.
  Future<void> testAddUser(String name, int score, RankType type){

    // Print new user document ID to console.
    this.db.collection("users").add(
    {
      "name" : name,
      "rank" : type.index,
      "score" : score,
    }).then((value){
      print("Created new user with ID " + value.documentID);
    });
  }

  /// Add a new recipe to Firestore database.
  Future<void> testAddRecipe(Recipe recipe){

    // Make map with recipe information.
    Map recipeMap = new HashMap<String, Object>();
    recipeMap.putIfAbsent("title", () => recipe.getTitle());
    recipeMap.putIfAbsent("description", () => recipe.getDescription());
    recipeMap.putIfAbsent("type", () => recipe.getType().index);
    recipeMap.putIfAbsent("isVegetarian", () => recipe.getIsVegetarian());
    recipeMap.putIfAbsent("duration", () => recipe.getDuration());
    recipeMap.putIfAbsent("ingredients", () => recipe.getIngredients());
    recipeMap.putIfAbsent("imageURL", () => recipe.getImageURL());

    // Print new recipe document ID to console.
    this.db.collection("recipes").add(recipeMap).then((value){
      print("Created new recipe with ID " + value.documentID);
    });
  }

  // Return recipe object when supplying it with a title.
  Future<Recipe> getRecipeFromTitle(String title) async{
    Recipe fetchedRecipe =
    await this.db.collection("recipes")
        .where("title", isEqualTo: title)
        .getDocuments()
        .then((QuerySnapshot docs){
        return docs.documents.isNotEmpty ? Recipe.fromMap(docs.documents[0].data, docs.documents[0].documentID) : null;
        });
    return fetchedRecipe;
  }
}