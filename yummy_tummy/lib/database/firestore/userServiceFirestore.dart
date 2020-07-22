import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/user.dart';
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
      "image" : user.image,
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

}