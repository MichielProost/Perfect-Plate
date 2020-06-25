import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/recipeService.dart';
import 'package:yummytummy/database/userService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/utils/storeData.dart';

// There is a fetch limit when querying from Firestore.
const int FETCH_LIMIT = 20;

class Test {
  final RecipeService recipeService;
  final UserService userService;

  /// Test constructor.
  Test() : this.recipeService = new RecipeService(), this.userService = new UserService();

  /// Define test methods here. Uncomment the functions you want to execute.
  void testMethods() async {

    //testAddRecipes();
    //testAddUser();
    testGetRecipeFromTitle();

    // Get vegetarian recipes from Firestore.
    //List<Recipe> vegetarianRecipes = await getVegetarianRecipes();
    // Print summary of all vegetarian recipes.
    //for (int i = 0; i < vegetarianRecipes.length; i++){
    //  vegetarianRecipes[i].printSummary();
    //}
  }

  /// TEST: Add recipes in temporary database (class storeData) to Firestore.
  void testAddRecipes(){
    // Temporary database.
    List<Recipe> recipes = getRecipes();

    // Add each recipe in database to Firestore.
    for(int i = 0; i < recipes.length; i++) {
      this.recipeService.addRecipe(recipes[i]);
      print("Creating new recipe...");
    }
  }

  /// TEST: Add a new user to Firestore.
  void testAddUser(){
    // Create a new user.
    User user = new User(
        name: 'Jeroen Meus',
        score: 9500,
        rank: RankType.professional,
        favourites: []
    );

    // Add new user to Firestore.
    this.userService.addUser(user);
    print("Creating new user...");
  }

  /// TEST: Get and prints recipe from Firestore when given a title.
  void testGetRecipeFromTitle() async{
    // Get recipe object from title.
    Recipe fetchedRecipe = await recipeService.getRecipeFromTitle("Panna cotta met tartaar van kiwi en kokoscrumble");
    // Print a summary of fetched recipe.
    fetchedRecipe.printSummary();
  }

  /// Last test method. Get all vegetarian recipes from Firestore.
  Future<List<Recipe>> getVegetarianRecipes() async {
    List<Recipe> fetchedRecipes=
    await Firestore.instance.collection("recipes")
        .where("isVegetarian", isEqualTo: true)
        .getDocuments()
        //.orderBy('name')
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