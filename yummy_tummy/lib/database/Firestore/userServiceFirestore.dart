import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/userService.dart';
import 'package:yummytummy/model/user.dart';

/// Firestore services involving recipes.
class UserServiceFirestore implements UserService{
  final db;

  /// Constructor.
  UserServiceFirestore() : this.db = Firestore.instance;

  /// Add new user to Firestore database.
  Future<void> addUser(User user){
    // Make map with user information.
    Map userMap = new HashMap<String, Object>();
    userMap.putIfAbsent("name", () => user.name);
    userMap.putIfAbsent("score", () => user.score);
    userMap.putIfAbsent("rank", () => user.rank.index);
    userMap.putIfAbsent("favourites", () => user.favourites);

    // Print new recipe document ID to console.
    this.db.collection("users").add(userMap).then((value) {
      print("Created new user with ID " + value.documentID);
    });
  }
}