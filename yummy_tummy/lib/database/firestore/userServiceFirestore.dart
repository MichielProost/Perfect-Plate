import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/firestore/reviewServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/storage/storageHandler.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/utils/consoleWriter.dart';

/// Firestore specific user services.
class UserServiceFirestore implements UserService {

  final db;
  final ConsoleWriter consoleWriter;

  /// Constructor.
  UserServiceFirestore() :
        this.db = Firestore.instance,
        this.consoleWriter = new ConsoleWriter();

  /// Add a new user to the database. Returns the document ID.
  Future<String> addUser(User user, String userID) async {

    DocumentReference docReference =
      this.db.collection("users").document(userID);

    // Create a new user document.
    String documentID =
    await docReference
        .setData(user.toMap())
        .then((value) {
      return docReference.documentID;
    });

    consoleWriter.CreatedDocument(CollectionType.User, documentID);
    return documentID;

  }

  /// Returns user object from document ID.
  Future<User> getUserFromID(String userID) async {

    User user =
    await this.db.collection("users")
        .document(userID)
        .get()
        .then((DocumentSnapshot snapshot){
      consoleWriter.FetchedDocument(CollectionType.User, snapshot.documentID);
      return snapshot.exists ?
          User.fromMap(snapshot.data, snapshot.documentID) : null;
    });

    return user;

  }

  /// Modify an existing user with a given document ID.
  Future<void> modifyUser(User user, String userID) async {

    await this.db.collection("users")
        .document(userID)
        .updateData({
      'name' : user.name,
      'score' : user.score,
      'rank' : user.rank.index,
      'favourites' : user.favourites,
      'dietFieldPreference' : user.dietFieldPreference.index,
      'recipeTypePreference' : user.recipeTypePreference.index,
      'languagePreference' : user.languagePreference.index,
      'image' : user.image,
      'board' : user.board.toMap(),
    });

    consoleWriter.ModifiedDocument(CollectionType.User, userID);

  }

  /// Returns true if user exists.
  Future<bool> userExists(String userID) async{

    bool exists = false;
    try {
      await this.db.collection("users")
          .document(userID)
          .get()
          .then((doc) {
        if (doc.exists){
          exists = true;
        } else {
          exists = false;
        }
      });
      return exists;
    } catch (e) {
      return false;
    }

  }

  /// Delete a user's profile picture.
  // ignore: missing_return
  Future<void> deleteProfilePicture(User user){

    // Create storage handler.
    StorageHandler handler = new StorageHandler();
    // Delete profile image from Firebase storage.
    handler.deleteImage(user.image);
    // Reset image field to an empty string.
    user.image = "";
    // Modify user document.
    modifyUser(user, user.id);

  }

  /// Listens to the app user's document for changes.
  void scoreListener() async {

    RecipeServiceFirestore recipeService = new RecipeServiceFirestore();
    ReviewServiceFirestore reviewService = new ReviewServiceFirestore();

    // Get document reference of logged-in user.
    DocumentReference reference =
      this.db.collection('users').document(Constants.appUser.id);

    // Listen for changes.
    reference.snapshots().listen((DocumentSnapshot documentSnapshot) async {

      // Get user object from received map.
      User user = User.fromMap(documentSnapshot.data, Constants.appUser.id);

      // If user's rank needs an upgrade.
      if (user.hasNextRank()){
        if (user.checkRankUpgrade()){
          // Upgrade rank.
          user.upgradeRank();
          modifyUser(user, Constants.appUser.id);

          // Modify userMap in user's recipes.
          Map<String, dynamic> userMap = user.toCompactMap();

          List<Recipe> recipes =
            await recipeService.getRecipesFromUser(UserMapField.id, Constants.appUser.id);
          for(int i = 0; i < recipes.length; i++){
            recipes[i].userMap = userMap;
            recipeService.modifyRecipe(recipes[i], recipes[i].id);
          }

          List<Review> reviews =
            await reviewService.getReviewsFromUser(UserMapField.id, Constants.appUser.id);
          for(int i = 0; i < reviews.length; i++){
            reviews[i].userMap = userMap;
            reviewService.modifyReview(reviews[i], reviews[i].id);
          }
        }
      }

      // Update global App User object.
      Constants.appUser.setUser(user);

    });

  }

}