import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/screen_handler.dart';
import 'model/test.dart';

/// Main function just runs the app.
void main() {
  Test test = new Test();
  test.testMethods();
  runApp(YummyTummy());
}

class YummyTummy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Yummy Tummy",
      // TODO implement home screen
      //home: HomeScreen(), 
      home: ScreenHandler(),
    );
  }

}