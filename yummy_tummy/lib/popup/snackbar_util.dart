import 'package:flutter/material.dart';

class SnackBarUtil {

  static SnackBar createTextSnackBar(String message)
  {
    return SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
  }

}