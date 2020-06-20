import 'package:flutter/material.dart';

import 'package:yummytummy/model/Database.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/home_screen.dart';

/// For testing purposes. Is to be removed later.
void testFirestore(){
  print("TESTING");
  Database db = new Database();
  db.addUser('tempUser', 0, RankType.beginner);
  print("TESTING");
}

/// Main function just runs the app.
void main() {
  //testFirestore();
  runApp(new HomeScreen());
}