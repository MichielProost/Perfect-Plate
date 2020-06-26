import 'package:yummytummy/model/recipe.dart';

/// INTERFACE: Same methods are issued when changing database.
abstract class RecipeService {
  /// Add new recipe to Firestore database.
  Future<void> addRecipe(Recipe recipe);

  /// Returns recipe object with given title.
  Future<Recipe> getRecipeFromTitle(String title);

  /// Get a list of recipes created by a specific user.
  Future<List<Recipe>> getRecipesFromUser(String name);
}