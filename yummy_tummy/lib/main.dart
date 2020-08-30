import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/home_screen.dart';

/// Main function just runs the app.
void main() {

  runApp(YummyTummy());

}

class YummyTummy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    
    // DummyDataHandler().createDummyRecipes(20);
    // DummyDataHandler().deleteDummyRecipes();

    return MaterialApp(
      title: "Perfect Plate",
      theme: Constants.globalTheme,
      home: HomeScreen(), 
      // home: ScreenHandler(),
    );
  }

}
