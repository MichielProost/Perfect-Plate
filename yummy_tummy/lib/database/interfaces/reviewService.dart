import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';

/// INTERFACE: Required methods when changing database.
abstract class ReviewService{

  /// Add a new [Review] to the database. Returns the document ID.
  Future<String> addReview(Review review);

  /// Delete a [Review] from the database when given a document ID [reviewID].
  Future<void> deleteReview(String reviewID);

  /// Returns [Review] object from document ID [reviewID].
  Future<Review> getReviewFromID(String reviewID);

  /// Modify an existing [Review] with a given document ID [reviewID].
  Future<void> modifyReview(Review review, String reviewID);

  /// Returns all [Review] objects made by a specific user.
  /// [field] : Specify user by name or id.
  /// [value] : Value of the field.
  Future<List<Review>> getReviewsFromUser(UserMapField field, String value);

  /// Returns all [Review] objects made for a specific [Recipe] with [recipeID].
  Future<List<Review>> getReviewsFromRecipe(String recipeID);

}