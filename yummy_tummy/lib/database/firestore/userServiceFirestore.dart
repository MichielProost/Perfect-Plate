import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/user.dart';

/// Firestore services involving recipes.
class UserServiceFirestore implements UserService{
  final db;

  /// Constructor.
  UserServiceFirestore() : this.db = Firestore.instance;

  /// Add new user to database. Return Document ID.
  Future<String> addUser(User user) async {
    // Make map with user information.
    Map userMap = new HashMap<String, Object>();
    userMap.putIfAbsent("name", () => user.name);
    userMap.putIfAbsent("score", () => user.score);
    userMap.putIfAbsent("rank", () => user.rank.index);
    userMap.putIfAbsent("favourites", () => user.favourites);

    // Add user to database and return document ID.
    String documentID =
    await this.db.collection("users")
        .add(userMap)
        .then((value) {
      return value.documentID;
    });
    return documentID;
  }
}