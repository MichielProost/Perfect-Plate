import 'package:flutter/material.dart';
import 'package:yummytummy/app.dart';
import 'package:yummytummy/model/Database.dart';
import 'package:yummytummy/model/user.dart';

/// For testing purposes. Is to be removed later.
void testFirestore(){
  Database db = new Database();
  db.addUser('tempUser', 0, RankType.beginner);
}

/// Main function just runs the app.
void main() {
  // testFirestore();
  runApp(new RecipesApp());
}