import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';

import '../query/queryInfo.dart';

/// INTERFACE: Required methods when changing database.
abstract class RecipeService {

  /// Add a new recipe to the database. Returns the document ID.
  Future<String> addRecipe(Recipe recipe);

  /// Delete a recipe from the database when given a document ID.
  Future<void> deleteRecipe(String recipeID);

  /// Returns recipe object from document ID.
  Future<Recipe> getRecipeFromID(String recipeID);

  /// Modify an existing recipe with a given document ID.
  Future<void> modifyRecipe(Recipe recipe, String recipeID);

  /// Returns recipe object with a given title.
  Future<Recipe> getRecipeFromTitle(String title);

  /// Returns all recipes made by a specific user.
  /// Field: Specify user by name or id.
  /// Value: Value of the field.
  Future<List<Recipe>> getRecipesFromUser(UserMapField field, String value);

  /// Returns all recipes in the user's favourite list.
  Future<List<Recipe>> getFavouriteRecipes(User user);

  /// Returns all vegetarian recipes.
  Future<List<Recipe>> getVegetarianRecipes(SortField sortField);

  /// Search recipes in the database by specifying fields.
  /// QueryInfo: Info of a particular query.
  /// SortField: Sort the acquired recipes.
  Future<RecipeQuery> searchRecipes(RecipeQuery info, SortField sortField, DietField dietField, RecipeType typeField, List<String> ingredients);

  /// Update average and weighted rating in recipe document.
  Future<void> updateRatings(Review review);
}