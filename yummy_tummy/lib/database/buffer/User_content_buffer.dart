import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/firestore/reviewServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/interfaces/reviewService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/constants.dart';

class UserContentBuffer {
  
  final RecipeService _recipeService = RecipeServiceFirestore();
  final ReviewService _reviewService = ReviewServiceFirestore();

  final List<Recipe> _recipes = List<Recipe>();
  final List<Review> _reviews = List<Review>();

  Future<List<Recipe>> getUserRecipes(User user) async
  {
    if (_recipes.length == 0)
      _recipes.addAll( await _recipeService.getRecipesFromUser(UserMapField.id, user.id) );
    
    return _recipes;
  }

    Future<List<Review>> getUserReviews(User user) async
  {
    if (_reviews.length == 0)
      _reviews.addAll( await _reviewService.getReviewsFromUser(UserMapField.id, Constants.appUser.id) );
    
    return _reviews;
  }

}