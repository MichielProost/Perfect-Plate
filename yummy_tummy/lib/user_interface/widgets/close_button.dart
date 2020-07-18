import 'package:flutter/material.dart';

class CloseButton extends StatelessWidget {
  
  final double size;

  CloseButton({this.size = 35.0});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.close, 
        size: this.size
      ),
      onPressed: () {
        Navigator.pop(context, null);
      },
    );
  }
}