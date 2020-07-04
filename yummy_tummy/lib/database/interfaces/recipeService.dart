import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';

/// INTERFACE: Required methods when changing database.
abstract class RecipeService {

  /// Add a new recipe to the database. Returns the document ID.
  Future<String> addRecipe(Recipe recipe);

  /// Delete a recipe from the database when given a document ID.
  Future<void> deleteRecipe(String recipeID);

  /// Returns recipe object with a given title.
  Future<Recipe> getRecipeFromTitle(String title);

  /// Returns all recipes made by a specific user.
  /// Field: Specify user by name or id.
  /// Value: Value of the field.
  Future<List<Recipe>> getRecipesFromUser(UserMapField field, String value);

  /// Returns all vegetarian recipes.
  Future<List<Recipe>> getVegetarianRecipes();

}