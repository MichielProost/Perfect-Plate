import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/review.dart';

/// Firestore specific review services.
class ReviewServiceFirestore{

  final db;

  /// Constructor.
  ReviewServiceFirestore() : this.db = Firestore.instance;

  /// Add a new review to the database. Returns the document ID.
  Future<void> addReview(Review review){

    // Create map from specified review object.
    Map reviewMap = new HashMap<String, Object>();
    reviewMap.putIfAbsent("userMap", () => review.userMap);
    reviewMap.putIfAbsent("recipeID", () => review.recipeID);
    reviewMap.putIfAbsent("rating", () => review.description);
    reviewMap.putIfAbsent("description", () => review.description);

    // Create a new review document.
    this.db.collection("reviews")
        .add(reviewMap)
        .then((value) {
      print("Created new review with ID " + value.documentID);
    });

  }

}