import 'package:yummytummy/model/review.dart';

/// INTERFACE: Required methods when changing database.
abstract class ReviewService{

  /// Add a new review to the database. Returns the document ID.
  Future<String> addReview(Review review);

}