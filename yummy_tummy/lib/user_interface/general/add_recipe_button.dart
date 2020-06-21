import 'package:flutter/material.dart';

import '../constants.dart';

class AddRecipeButton extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () => print("Add new recipe!"),
        child: Icon(Icons.add),
        backgroundColor: Constants.main,
      );
  }
}