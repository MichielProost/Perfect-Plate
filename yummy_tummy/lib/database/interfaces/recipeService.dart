import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';

/// INTERFACE: Same methods are issued when changing database.
abstract class RecipeService {
  /// Add new recipe to database. Return Document ID.
  Future<String> addRecipe(Recipe recipe);

  /// Returns recipe object with given title.
  Future<Recipe> getRecipeFromTitle(String title);

  /// Get a list of recipes created by a user.
  /// Specify field of UserMap ("id" or "name")
  /// Specify value of field.
  Future<List<Recipe>> getRecipesFromUser(UserMapField field, String value);

  /// Get a list of vegetarian recipes (no limit yet).
  Future<List<Recipe>> getVegetarianRecipes();
}