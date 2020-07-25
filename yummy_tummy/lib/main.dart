import 'package:flutter/material.dart';
import 'package:yummytummy/database/authentication/google.dart';
import 'package:yummytummy/user_interface/screen_handler.dart';
import 'model/test.dart';

/// Main function just runs the app.
void main() {
  runApp(YummyTummy());
  Test test = new Test();
  test.testMethods();
}

class YummyTummy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    GoogleAuthHandler().handleSignIn();
    
    return MaterialApp(
      title: "Yummy Tummy",
      // TODO implement home screen
      //home: HomeScreen(), 
      home: ScreenHandler(),
    );
  }

}