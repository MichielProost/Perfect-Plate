import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/user.dart';

class Test{
  final db;

  /// Test constructor.
  Test() : this.db = Firestore.instance;

  /// Define test methods here.
  void testMethods() async {
    print("Test methods.");
    var userID = await testAddUser("tempUser", 0, RankType.beginner);
    print("Creating now user document...");
  }

  /// Add a new user to Firestore database.
  Future<String> testAddUser(String name, int score, RankType type){
    // Test
    print("In TestAddUser method...");

    // Print new document ID to console.
    this.db.collection("users").add(
    {
      "name" : name,
      "score" : score,
      "rank"  : type,
    }).then((value){
      print("Document ID: "+ value.documentID);
      return Future.delayed(null, () => value.documentID);
    });
  }
}