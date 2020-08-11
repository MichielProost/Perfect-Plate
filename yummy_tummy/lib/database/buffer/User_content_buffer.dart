import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/firestore/reviewServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/interfaces/reviewService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/constants.dart';

// TODO Implement local cache when adding/deleting recipes/reviews
class UserContentBuffer {
  
  final RecipeService _recipeService = RecipeServiceFirestore();
  final ReviewService _reviewService = ReviewServiceFirestore();

  List<Recipe> _recipes = List<Recipe>();
  List<Review> _reviews = List<Review>();

  bool _hasFetchedRecipes = false;
  bool _hasFetchedReviews = false;

  UserContentBuffer._privateConstructor();

  static final UserContentBuffer _instance = UserContentBuffer._privateConstructor();

  static UserContentBuffer get instance => _instance;

  /// Add a [Recipe] to the local cache
  void addRecipe(Recipe recipe)
  {
    // _recipes.add( recipe );
  }

  /// Deletes the [Recipe] with the same ID from the cache
  /// Will fail silently if the ID is not found
  void removeRecipe(Recipe recipe)
  {
    // _recipes.removeWhere((element) => element.id == recipe.id);
  }

  /// Add a [Review] to the local cache
  void addReview(Review review)
  {
    // _reviews.add( review );
  }

  /// Deletes the [Review] with the same ID from the cache
  /// Will fail silently if the ID is not found
  void removeReview(Review review)
  {
    // _recipes.removeWhere((element) => element.id == review.id);
  }

  /// Get the list of type [Recipe] that this [User] has created
  /// Will do a database call the first time this is called
  /// Or when calling this for a second time, from local cache to reduce reads
  Future<List<Recipe>> getUserRecipes(User user) async
  {
    if ( !_hasFetchedRecipes ) {
      _hasFetchedRecipes = true;
      _recipes = List<Recipe>();
      _recipes.addAll( await _recipeService.getRecipesFromUser(UserMapField.id, user.id) );
    }
    
    return _recipes;
  }

  /// Get the list of type [Review] that this [User] has created
  /// Will do a database call the first time this is called
  /// Or when calling this for a second time, from local cache to reduce reads
  Future<List<Review>> getUserReviews(User user) async
  {
    if ( !_hasFetchedReviews ) {
      _hasFetchedReviews = true;
      _reviews = List<Review>();
      _reviews.addAll( await _reviewService.getReviewsFromUser(UserMapField.id, Constants.appUser.id) );
    }
    
    return _reviews;
  }

}