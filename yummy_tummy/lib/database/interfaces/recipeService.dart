import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

import '../query/queryInfo.dart';

/// INTERFACE: Required methods when changing database.
abstract class RecipeService {

  /// Add a new [Recipe] to the database. Returns the document ID.
  Future<String> addRecipe(Recipe recipe);

  /// Delete a [Recipe] from the database when given a document ID [recipeID].
  Future<void> deleteRecipe(String recipeID);

  /// Returns [Recipe] object from document ID [recipeID].
  Future<Recipe> getRecipeFromID(String recipeID);

  /// Modify an existing [Recipe] with a given document ID [recipeID].
  Future<void> modifyRecipe(Recipe recipe, String recipeID);

  /// Returns a list of [Recipe] objects that match this exact title.
  /// Never returns null, but can return an empty list if no matches are found.
  Future<List<Recipe>> getRecipesFromTitle(String title);

  /// Returns all recipes made by a specific user.
  /// [field] : Specify user by name or id.
  /// [value] : Value of the field.
  Future<List<Recipe>> getRecipesFromUser(UserMapField field, String value);

  /// Returns all [Recipe] objects in the user's favourite list.
  Future<List<Recipe>> getFavouriteRecipes(User user);

  /// Returns all vegetarian [Recipe] objects.
  Future<List<Recipe>> getVegetarianRecipes(SortField sortField);

  /// Search recipes in the database by specifying fields.
  /// [QueryInfo] : Info of a particular query.
  /// [SortField] : Sort the acquired recipes.
  /// [dietField] : Desired diet of recipes. Should be [DietField.any] when all diets are allowed.
  /// [typeField] : Desired type of recipes. Should be [RecipeType.any] when all types are allowed.
  /// [ingredients] : The ingredients that the recipes should contain. Should be an empty string if all recipes are allowed.
  /// [language] : Desired language of recipes.
  Future<RecipeQuery> searchRecipes(RecipeQuery info, SortField sortField, DietField dietField, RecipeType typeField, List<String> ingredients, {LanguagePick language});

  /// Update ratings (average and weighted) in [Recipe] document.
  /// [review] : A new review to a particular recipe.
  Future<void> updateRatings(Review review);
}