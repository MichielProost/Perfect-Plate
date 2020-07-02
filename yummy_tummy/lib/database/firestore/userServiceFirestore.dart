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
  Future<String> addUser(User user) async {

    // Create map from specified user object.
    Map userMap = new HashMap<String, Object>();
    userMap.putIfAbsent("name", () => user.name);
    userMap.putIfAbsent("score", () => user.score);
    userMap.putIfAbsent("rank", () => user.rank.index);
    userMap.putIfAbsent("favourites", () => user.favourites);

    // Create a new user document.
    String documentID =
    await this.db.collection("users")
        .add(userMap)
        .then((value) {
      return value.documentID;
    });

    consoleWriter.CreatedDocument(CollectionType.User, documentID);
    return documentID;

  }

}