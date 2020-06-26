import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/review.dart';

class ReviewServiceFirestore{
  final db;

  /// Constructor.
  ReviewServiceFirestore() : this.db = Firestore.instance;

  /// Add new recipe to Firestore database.
  Future<void> addReview(Review review){
    // Make map with review information.
    Map reviewMap = new HashMap<String, Object>();
    reviewMap.putIfAbsent("userMap", () => review.userMap);
    reviewMap.putIfAbsent("recipeID", () => review.recipeID);
    reviewMap.putIfAbsent("rating", () => review.description);
    reviewMap.putIfAbsent("description", () => review.description);

    // Print new review document ID to console.
    this.db.collection("reviews").add(reviewMap).then((value) {
      print("Created new review with ID " + value.documentID);
    });
  }
}