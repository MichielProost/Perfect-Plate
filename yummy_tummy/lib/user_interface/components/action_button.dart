import 'package:flutter/material.dart';

import '../constants.dart';

class ActionButton extends StatelessWidget {
  
  final VoidCallback onClick;
  final String text;
  final double width;

  ActionButton(this.text, {this.width: 250.0, this.onClick});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: this.width,
      child: RaisedButton(
        color: Constants.main,
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0
          ),
        ),
        onPressed: () {
          if (onClick != null)
            onClick();
        }
      ),
    );
  }

}