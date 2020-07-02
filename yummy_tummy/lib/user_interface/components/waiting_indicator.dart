import 'package:flutter/material.dart';

import '../constants.dart';

class WaitingIndicator extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Constants.accent,
        valueColor: new AlwaysStoppedAnimation<Color>(Constants.main),
        strokeWidth: 5.0,
      ));
  }

}