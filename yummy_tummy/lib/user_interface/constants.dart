import 'package:flutter/material.dart';
import 'package:yummytummy/model/app_user.dart';

class Constants {

  static AppUser appUser = AppUser.offline();
  
  static final String magnetarID = 'sHwl9iXDmFYItA6swCpK';

  static final Color main = Color(0xFFFF0000);
  static final Color accent = Color(0xFFFBC02D);
  static final Color gray = Colors.grey.shade50;
  static final Color bg_gray = Colors.grey.shade300;
  static final Color text_gray = Colors.grey.shade600;
  static final Color green = Colors.green;
  static final Color background = Colors.grey.shade200;

  static final TextStyle buttonStyle = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.bold,
    color: main,
  );

  static final TextStyle emptyScreenStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold
  );

  static final ThemeData themeData = ThemeData(
    accentColor: main,
  );
}
