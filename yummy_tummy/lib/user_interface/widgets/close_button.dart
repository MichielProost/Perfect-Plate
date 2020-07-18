import 'package:flutter/material.dart';

class CloseButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.close, size: 35.0),
      onPressed: () {
        Navigator.pop(context, null);
      },
    );
  }
}