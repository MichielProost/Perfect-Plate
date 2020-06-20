import 'dart:collection';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/user.dart';

//final databaseReference = Firestore.instance;

class Database{
  void addUser(String name, int score, RankType type){
    ///Test?
    print('THIS WORKED!');

    /// Make map with new user information.
    Map user = new HashMap<String, Object>();
    user.putIfAbsent('name', () => name);
    user.putIfAbsent('score', () => score);
    user.putIfAbsent('type', () => type);
    print(user);

    /// Add a new document with a generated ID.
  //  databaseReference.collection("users").add(user);
  }
}