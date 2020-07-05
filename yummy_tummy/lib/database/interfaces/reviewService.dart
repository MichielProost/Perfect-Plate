import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';

/// INTERFACE: Required methods when changing database.
abstract class ReviewService{

  /// Add a new review to the database. Returns the document ID.
  Future<String> addReview(Review review);

  /// Delete a review from the database when given a document ID.
  Future<void> deleteReview(String reviewID);

  /// Returns review object from document ID.
  Future<Review> getReviewFromID(String reviewID);

  /// Modify an existing review with a given document ID.
  Future<void> modifyReview(Review review, String reviewID);

  /// Returns all reviews made by a specific user.
  /// Field: Specify user by name or id.
  /// Value: Value of the field.
  Future<List<Review>> getReviewsFromUser(UserMapField field, String value);

  /// Returns all reviews made for a specific recipe.
  Future<List<Review>> getReviewsFromRecipe(String recipeID);

}