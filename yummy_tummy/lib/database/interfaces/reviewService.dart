import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';

/// INTERFACE: Required methods when changing database.
abstract class ReviewService{

  /// Add a new review to the database. Returns the document ID.
  Future<String> addReview(Review review);

  /// Returns all reviews made by a specific user.
  /// Field: Specify user by name or id.
  /// Value: Value of the field.
  Future<List<Review>> getReviewsFromUser(UserMapField field, String value);

  /// Returns all reviews made for a specific recipe.
  Future<List<Review>> getReviewsFromRecipe(String recipeID);

}