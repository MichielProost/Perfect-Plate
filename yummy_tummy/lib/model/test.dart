import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yummytummy/database/Firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/Firestore/reviewServiceFirestore.dart';
import 'package:yummytummy/database/Firestore/userServiceFirestore.dart';
import 'package:yummytummy/database/authentication/google.dart';
import 'package:yummytummy/database/dummy/dummydatabase.dart';
import 'package:yummytummy/database/query/queryInfo.dart';
import 'package:yummytummy/model/app_user.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/storage/storageHandler.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/utils/consoleWriter.dart';

import 'medal.dart';

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
    //testGetRecipeFromTitle();
    //testAddReview();
    //testGetRecipesFromUser();
    //testGetVegetarianRecipes();
    //testGetReviewsFromUser();
    //testGetReviewsFromRecipe();
    //testGetUserFromID();
    //testDeleteRecipe();
    //testDeleteReview();
    //testGetRecipeFromID();
    //testGetFavouriteRecipes();
    //testModifyRecipe();
    //testSearchRecipes();
    //testGoogle();
    //testUpdateRatings();
    //testUploadPicture();
    //testScoreListener();
    testMethod();

  }

  testMethod() async {

    // Create Google handler.
    GoogleAuthHandler handler = new GoogleAuthHandler();
    // Sign in Google user.
    await handler.handleSignIn();

  }

  /// TEST: Add recipes from the StoreData Class to Firestore.
  void testAddRecipes() async {

    // Get recipes from StoreData Class.
    List<Recipe> recipes = DummyDatabase().getRecipes();

    // Add each recipe in list to Firestore.
    for(int i = 0; i < recipes.length; i++) {
      String documentID = await recipeService.addRecipe(recipes[i]);
      print("Document ID: " + documentID);
      print("Creating new recipe...");
    }

  }

  /// TEST: Add a new user to Firestore.
  void testAddUser() async {

    // Create user object.
    User user = new User(
        name: 'Ann Van Geystelen',
        score: 1500,
        rank: RankType.dishwasher,
        favourites: []
    );

    // Add user to Firestore.
    String userID = "TestID";
    String documentID = await userService.addUser(user, userID);
    print("Document ID: " + documentID);
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
      userMap: {'id' : 'v9KKgUEnDStdzlVWICR3', 'name' : 'Tony Proost', 'Rank' : RankType.head_chef.index},
      recipeID: 'dosiN0h6qjoidjSGRURS',
      rating: 4,
      description: 'Loved the recipe, but the chef used a lot of ingredients.'
    );

    // Add review to Firestore.
    String documentID = await reviewService.addReview(review);
    print("Document ID: " + documentID);
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

    List<Recipe> recipes = await recipeService.getVegetarianRecipes(SortField.rating);
    // Print summary of all recipes.
    for (int i = 0; i < recipes.length; i++) {
      recipes[i].printSummary();
    }
  }

  /// TEST: Get all reviews made by a specific user.
  void testGetReviewsFromUser() async {

    List<Review> reviews = await reviewService.getReviewsFromUser(UserMapField.name, "Jeroen Meus");
    // Print summary of fetched reviews.
    for (int i = 0; i < reviews.length; i++) {
      reviews[i].printSummary();
    }

  }

  /// TEST: Get all reviews made for a specific recipe.
  void testGetReviewsFromRecipe() async {

    List<Review> reviews = await reviewService.getReviewsFromRecipe("DSPzAAQHbGm2PJibhDVi");
    // Print summary of fetched reviews.
    for (int i = 0; i < reviews.length; i++) {
      reviews[i].printSummary();
    }

  }

  /// TEST: Get a specific user from Firestore.
  void testGetUserFromID() async {

    // Get user object from ID.
    User fetchedUser = await userService.getUserFromID("1w7FGM8kiBbk3iwJB7b2");
    // Print summary of fetched user.
    fetchedUser.printSummary();

  }
  
  /// TEST: Delete a recipe from the database.
  void testDeleteRecipe() async {

    recipeService.deleteRecipe("89koX9rhGmeHlpD6ooz2");
    
  }

  /// TEST: Delete a review from the database.
  void testDeleteReview() async {

    reviewService.deleteReview("er6J7r2Z0G92NxthHZy5");

  }

  /// TEST: Get a specific recipe from Firestore.
  void testGetRecipeFromID() async {

    // Get recipe object from ID.
    Recipe fetchedRecipe = await recipeService.getRecipeFromID("1m9wVtvQSdw5KzArL0Rk");
    // Print summary of fetched recipe.
    fetchedRecipe.printSummary();

  }

  /// TEST: Get the user's favourite recipes.
  testGetFavouriteRecipes() async {

    User fetchedUser = await userService.getUserFromID("1w7FGM8kiBbk3iwJB7b2");
    List<Recipe> recipes = await recipeService.getFavouriteRecipes(fetchedUser);
    // Print summary of all recipes.
    for (int i = 0; i < recipes.length; i++) {
      recipes[i].printSummary();
    }

  }

  /// TEST: Modify an existing review.
  testModifyRecipe() async {

    Recipe recipe = await recipeService.getRecipeFromTitle("Panna cotta met tartaar van kiwi en kokoscrumble");
    recipe.title = "Other title";
    await recipeService.modifyRecipe(recipe, recipe.id);

  }

  /// TEST: Search recipes based on a number of criteria.
  testSearchRecipes() async {

    // Initialize new query.
    RecipeQuery info = new RecipeQuery();
    List<String> ingredients = [];

    // Stop when there are no more recipes to fetch.
    while(info.hasMore){
      // Fetch recipes. Update RecipeQuery object.
      info = await recipeService.searchRecipes(info, SortField.weightedRating, DietField.any, RecipeType.any, ingredients);

      // Print query information
      print(info.hasMore);

      // Print all recipes in RecipeQuery object
      List<Recipe> recipes = info.recipes;
      for(int i=0; i<recipes.length; i++){
        recipes[i].printSummary();
      }
    }

  }

  /// TEST: Sign in and out with Google.
  testGoogle() async {

    // Create Google handler.
    GoogleAuthHandler handler = new GoogleAuthHandler();
    // Sign in Google user.
    await handler.handleSignIn();
    // Print summary of logged in user object.
    Constants.appUser.printSummary();
    // Sign out Google user.
    await handler.handleSignOut();
    // Is logged in?
    print(Constants.appUser.isLoggedIn());

  }

  /// TEST: Update recipe ratings based on new review.
  testUpdateRatings() async {

    // Create review object.
    Review review = new Review(
        recipeID: '7jrZah08KuNUMz4ATAR4',
        rating: 1,
    );

    await recipeService.updateRatings(review);

  }

  testUploadPicture() async {

    // Create Google handler.
    GoogleAuthHandler handler = new GoogleAuthHandler();
    // Sign in Google user.
    await handler.handleSignIn();

    // Create storage handler.
    StorageHandler storageHandler = new StorageHandler();
    // Take image with phone camera.
    File image = await storageHandler.getPicture(ImageSource.camera);
    // Upload image to Firebase.
    // Set appropriate fields in user document.
    await storageHandler.uploadAndSetProfileImage(image);

  }

  testScoreListener() async {

    // Create Google handler.
    GoogleAuthHandler handler = new GoogleAuthHandler();
    // Sign in Google user.
    await handler.handleSignIn();

    // Dynamically update user's rank when necessary.
    userService.scoreListener();

  }

 }