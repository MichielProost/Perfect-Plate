import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/user.dart';

class Database{
  void addUser(String name, int score, RankType type){
    /// Make map with new user information.
    ///Map user = new HashMap<String, Object>();
    ///user.putIfAbsent('name', () => name);
    ///user.putIfAbsent('score', () => score);
    ///user.putIfAbsent('type', () => type);

    /// Print user on console as test.
    ///print(user);

    print("TEST");

    /// Create Firestore database.
    final db = Firestore.instance;

    print("Now creating document");

    /// Add a new document with a generated ID.
    db.collection("users").add(
    {
      "name" : name,
      "score" : score,
      "rank"  : type,
    }).then((value){
      print("Document ID:" + value.documentID);
    });
    print("We are here!");
  }
}