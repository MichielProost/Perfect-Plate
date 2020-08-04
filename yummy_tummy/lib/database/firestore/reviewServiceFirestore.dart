import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
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

    // Create a new review document.
    String documentID =
    await this.db.collection("reviews")
        .add(review.toMap())
        .then((value) {
      return value.documentID;
    });

    // Update ratings of reviewed recipe.
    RecipeServiceFirestore recipeService = new RecipeServiceFirestore();
    recipeService.updateRatings(review);

    consoleWriter.CreatedDocument(CollectionType.Review, documentID);
    return documentID;

  }

  /// Delete a review from the database when given a document ID.
  Future<void> deleteReview(String reviewID) async {

    this.db.collection("reviews")
        .document(reviewID)
        .delete();

    consoleWriter.DeletedDocument(CollectionType.Review, reviewID);

  }

  /// Returns review object from document ID.
  Future<Review> getReviewFromID(String reviewID) async {

    Review review =
        await this.db.collection("reviews")
        .document(reviewID)
        .get()
        .then((DocumentSnapshot snapshot){
      consoleWriter.FetchedDocument(CollectionType.Review, snapshot.documentID);
      return snapshot.exists ?
          Review.fromMap(snapshot.data, snapshot.documentID) : null;
    });

    return review;

  }

  /// Modify an existing review with a given document ID.
  Future<void> modifyReview(Review review, String reviewID) async {

    await this.db.collection("reviews")
        .document(reviewID)
        .updateData({
      "rating" : review.rating,
      "description" : review.description,
      "userMap" : review.userMap,
    });

    consoleWriter.ModifiedDocument(CollectionType.Review, reviewID);

  }

  /// Returns all reviews made by a specific user.
  /// Field: Specify user by name or id.
  /// Value: Value of the field.
  Future<List<Review>> getReviewsFromUser(UserMapField field, String value) async {

    List<Review> fetchedReviews=
    await this.db.collection("reviews")
        .where("userMap." + field.toString().split(".").last, isEqualTo: value)
        .orderBy("timestamp", descending: true)
        .getDocuments()
        .then((QuerySnapshot docs){
      Review review;
      List<Review> reviews = new List(docs.documents.length);
      for (int i = 0; i < docs.documents.length; i++){
        review = Review.fromMap(docs.documents[i].data, docs.documents[i].documentID);
        reviews[i] = review;
        consoleWriter.FetchedDocument(CollectionType.Review, review.id);
      }
      return docs.documents.isNotEmpty ? reviews : List<Review>();
    });
    return fetchedReviews;

  }

  /// Returns all reviews made for a specific recipe.
  Future<List<Review>> getReviewsFromRecipe(String recipeID) async {

    List<Review> fetchedReviews=
        await this.db.collection("reviews")
        .where("recipeID", isEqualTo: recipeID)
        .orderBy("timestamp", descending: true)
        .getDocuments()
        .then((QuerySnapshot docs){
      Review review;
      List<Review> reviews = new List(docs.documents.length);
      for (int i = 0; i < docs.documents.length; i++){
        review = Review.fromMap(docs.documents[i].data, docs.documents[i].documentID);
        reviews[i] = review;
        consoleWriter.FetchedDocument(CollectionType.Review, review.id);
      }
      return docs.documents.isNotEmpty ? reviews : List<Review>();
    });
    return fetchedReviews;

  }

}