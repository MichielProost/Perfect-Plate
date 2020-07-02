import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/interfaces/reviewService.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/utils/consoleWriter.dart';

/// Firestore specific review services.
class ReviewServiceFirestore implements ReviewService {

  final db;
  final ConsoleWriter consoleWriter;

  /// Constructor.
  ReviewServiceFirestore() :
        this.db = Firestore.instance,
        this.consoleWriter = new ConsoleWriter();

  /// Add a new review to the database. Returns the document ID.
  Future<String> addReview(Review review) async {

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

    consoleWriter.CreatedDocument(CollectionType.Review, documentID);
    return documentID;

  }

  /// Returns all reviews made by a specific user.
  /// Field: Specify user by name or id.
  /// Value: Value of the field.
  Future<List<Review>> getReviewsFromUser(UserMapField field, String value) async {

    List<Review> fetchedReviews=
    await this.db.collection("reviews")
        .where("userMap." + field.toString().split(".").last, isEqualTo: value)
        .getDocuments()
        .then((QuerySnapshot docs){
      Review review;
      List<Review> reviews = new List(docs.documents.length);
      for (int i = 0; i < docs.documents.length; i++){
        review = Review.fromMap(docs.documents[i].data, docs.documents[i].documentID);
        reviews[i] = review;
        consoleWriter.FetchedDocument(CollectionType.Review, review.id);
      }
      return docs.documents.isNotEmpty ? reviews : null;
    });
    return fetchedReviews;

  }

  /// Returns all reviews made for a specific recipe.
  Future<List<Review>> getReviewsFromRecipe(String recipeID) async {

    List<Review> fetchedReviews=
        await this.db.collection("reviews")
        .where("recipeID", isEqualTo: recipeID)
        .getDocuments()
        .then((QuerySnapshot docs){
      Review review;
      List<Review> reviews = new List(docs.documents.length);
      for (int i = 0; i < docs.documents.length; i++){
        review = Review.fromMap(docs.documents[i].data, docs.documents[i].documentID);
        reviews[i] = review;
        consoleWriter.FetchedDocument(CollectionType.Review, review.id);
      }
      return docs.documents.isNotEmpty ? reviews : null;
    });
    return fetchedReviews;

  }

}