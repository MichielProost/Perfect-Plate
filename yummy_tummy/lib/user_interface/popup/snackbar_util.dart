import 'package:flutter/material.dart';

class SnackBarUtil {

  static SnackBar createTextSnackBar(String message)
  {
    return SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
  }

  static void showTextSnackBar(BuildContext context, String message)
  {
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar( createTextSnackBar(message) );
  }

}