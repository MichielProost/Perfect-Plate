import 'package:yummytummy/model/user.dart';

/// Still needs to be implemented.
/// Temporary placeholder.
class Review{
  final User user;
  final int rating;
  final String description;

  const Review({
    this.user,
    this.rating,
    this.description,
  });

  /// Returns author of review.
  User getUser(){
    return this.user;
  }

  /// Returns review's rating.
  int getRating(){
    return this.rating;
  }

  /// Returns review's description
  String getDescription(){
    return this.description;
  }
}