import 'package:yummytummy/database/Firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/Firestore/reviewServiceFirestore.dart';
import 'package:yummytummy/database/Firestore/userServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/utils/consoleWriter.dart';
import 'package:yummytummy/utils/storeData.dart';

class Test {

  final RecipeServiceFirestore recipeService;
  final UserServiceFirestore userService;
  final ReviewServiceFirestore reviewService;
  final ConsoleWriter consoleWriter;

  /// Constructor.
  Test() :
        this.recipeService = new RecipeServiceFirestore(),
        this.userService = new UserServiceFirestore(),
        this.reviewService = new ReviewServiceFirestore(),
        this.consoleWriter = new ConsoleWriter();

  /// Define test methods here. Uncomment the functions you want to execute.
  void testMethods() async {

    //testAddRecipes();
    //testAddUser();
    testGetRecipeFromTitle();
    //testAddReview();
    //testGetRecipesFromUser();
    //testGetVegetarianRecipes();

  }

  /// TEST: Add recipes from the StoreData Class to Firestore.
  void testAddRecipes() async {

    // Get recipes from StoreData Class.
    List<Recipe> recipes = getRecipes();

    // Add each recipe in list to Firestore.
    for(int i = 0; i < recipes.length; i++) {
      String documentID = await recipeService.addRecipe(recipes[i]);
      consoleWriter.CreatedDocument(CollectionType.Recipe, documentID);
      print("Creating new recipe...");
    }

  }

  /// TEST: Add a new user to Firestore.
  void testAddUser() async {

    // Create user object.
    User user = new User(
        name: 'Ann Van Geystelen',
        score: 1500,
        rank: RankType.amateur,
        favourites: []
    );

    // Add user to Firestore.
    String documentID = await userService.addUser(user);
    consoleWriter.CreatedDocument(CollectionType.User, documentID);
    print("Creating new user...");

  }

  /// TEST: Get a specific recipe from Firestore.
  void testGetRecipeFromTitle() async {

    // Get recipe object from title.
    Recipe fetchedRecipe = await recipeService.getRecipeFromTitle("Panna cotta met tartaar van kiwi en kokoscrumble");
    // Print summary of fetched recipe.
    fetchedRecipe.printSummary();

  }

  /// TEST: Add a new review to Firestore.
  void testAddReview() async {

    // Create review object.
    Review review = new Review(
      userMap: {'id' : '1w7FGM8kiBbk3iwJB7b2', 'name' : 'Jeroen Meus', 'Rank' : RankType.professional.index},
      recipeID: 'DSPzAAQHbGm2PJibhDVi',
      rating: 4,
      description: 'Amazing recipe Michiel! Keep it up!'
    );

    // Add review to Firestore.
    String documentID = await reviewService.addReview(review);
    consoleWriter.CreatedDocument(CollectionType.Review, documentID);
    print("Creating new review...");

  }

  /// TEST: Get all recipes made by a specific user.
  void testGetRecipesFromUser() async {

    List<Recipe> recipes = await recipeService.getRecipesFromUser(UserMapField.name, "Jeroen Meus");
    // Print summary of fetched recipes.
    for (int i = 0; i < recipes.length; i++) {
      recipes[i].printSummary();
    }

  }

  /// TEST: Get all vegetarian recipes in Firestore.
  void testGetVegetarianRecipes() async {

    List<Recipe> recipes = await recipeService.getVegetarianRecipes();
    // Print summary of all recipes.
    for (int i = 0; i < recipes.length; i++) {
      recipes[i].printSummary();
    }
  }

}