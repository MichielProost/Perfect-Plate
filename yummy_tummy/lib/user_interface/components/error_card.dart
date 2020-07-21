import 'package:flutter/material.dart';

import '../constants.dart';

class ErrorCard extends StatelessWidget {

  final String error;

  ErrorCard(this.error);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      child: Card(
        color: Constants.bg_gray,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.main,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

}