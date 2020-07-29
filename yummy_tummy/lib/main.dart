import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yummytummy/database/authentication/google.dart';
import 'package:yummytummy/database/firestore_dummydata/dummydata_handler.dart';
import 'package:yummytummy/user_interface/home_screen.dart';
import 'package:yummytummy/user_interface/screen_handler.dart';
import 'model/test.dart';

/// Main function just runs the app.
void main() {
  runApp(YummyTummy());
  // Test test = new Test();
  // test.testMethods();
}

class YummyTummy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    GoogleAuthHandler().handleSignIn();
    
    // DummyDataHandler().createDummyRecipes(20);
    // DummyDataHandler().deleteDummyRecipes();

    return MaterialApp(
      title: "Yummy Tummy",
      home: HomeScreen(), 
      // home: ScreenHandler(),
    );
  }

}