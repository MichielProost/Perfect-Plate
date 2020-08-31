import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/buffer/User_content_buffer.dart';
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

  /// Add a new [Review] to the database. Returns the document ID.
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

    // TODO Make sure all fields are present in review
    // Add the newly created review to cache
    UserContentBuffer.instance.addReview( review );

    consoleWriter.CreatedDocument(CollectionType.Review, documentID);
    return documentID;

  }

  /// Delete a [Review] from the database when given a document ID [reviewID].
  Future<void> deleteReview(String reviewID) async {

    this.db.collection("reviews")
        .document(reviewID)
        .delete();

    // TODO Make sure all fields are present in review
    // Remove this review from cache
    UserContentBuffer.instance.removeReview( Review(id: reviewID) );

    consoleWriter.DeletedDocument(CollectionType.Review, reviewID);

  }

  /// Returns [Review] object from document ID [reviewID].
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

  /// Modify an existing [Review] with a given document ID [reviewID].
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

  /// Returns all [Review] objects made by a specific user.
  /// [field] : Specify user by name or id.
  /// [value] : Value of the field.
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

  /// Returns all [Review] objects made for a specific [Recipe] with [recipeID].
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