import 'package:yummytummy/model/review.dart';

/// INTERFACE: Same methods are issued when changing database.
abstract class ReviewService{
  /// Add new recipe to Firestore database.
  Future<void> addReview(Review review);
}