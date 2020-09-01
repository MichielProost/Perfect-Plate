import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

/// Main function just runs the app.
void main() {

  runApp(YummyTummy());

}

class YummyTummy extends StatelessWidget {

  void _initPermissions() async
  {
    await Permission.camera.request();
    await Permission.photos.request();
  }

  @override
  Widget build(BuildContext context) {
    
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    
    // DummyDataHandler().createDummyRecipes(20);
    // DummyDataHandler().deleteDummyRecipes();

    _initPermissions();

    return MaterialApp(
      title: "Perfect Plate",
      theme: Constants.globalTheme,
      home: HomeScreen(), 
      // home: ScreenHandler(),
    );
  }

}
