import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/review.dart';

/// Firestore specific review services.
class ReviewServiceFirestore{

  final db;

  /// Constructor.
  ReviewServiceFirestore() : this.db = Firestore.instance;

  /// Add a new review to the database. Returns the document ID.
  Future<String> addReview(Review review) async{

    // Create map from specified review object.
    Map reviewMap = new HashMap<String, Object>();
    reviewMap.putIfAbsent("userMap", () => review.userMap);
    reviewMap.putIfAbsent("recipeID", () => review.recipeID);
    reviewMap.putIfAbsent("rating", () => review.rating);
    reviewMap.putIfAbsent("description", () => review.description);

    // Create a new review document.
    String documentID =
    await this.db.collection("reviews")
        .add(reviewMap)
        .then((value) {
      return value.documentID;
    });
    return documentID;

  }

}