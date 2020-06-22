import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/user.dart';

class Test{
  final db;

  /// Test constructor.
  Test() : this.db = Firestore.instance;

  /// Define test methods here.
  void testMethods() async {
    testAddUser("tempUser", 0, RankType.beginner);
    print("Creating user document...");
  }

  /// Add a new user to Firestore database.
  Future<String> testAddUser(String name, int score, RankType type){

    // Print new document ID to console.
    this.db.collection("users").add(
    {
      "name" : name,
      "rank" : type.index,
      "score" : score,
    }).then((value){
      print("Created new user with ID " + value.documentID);
    });
  }
}