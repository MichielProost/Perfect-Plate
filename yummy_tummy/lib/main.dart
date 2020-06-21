import 'package:flutter/material.dart';

import 'package:yummytummy/model/Database.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/home_screen.dart';

/// For testing purposes. Is to be removed later.
void testFirestore(){
  Database db = new Database();
  db.addUser('tempUser', 0, RankType.beginner);
}

/// Main function just runs the app.
void main() {
  //testFirestore();
  runApp(YummyTummy());
}

class YummyTummy extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Yummy Tummy",
      home: HomeScreen(),
    );
  }

}