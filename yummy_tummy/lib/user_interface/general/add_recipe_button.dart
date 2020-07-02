import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/popup/recipe_page.dart';

import '../constants.dart';

class AddRecipeButton extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.add),
        backgroundColor: Constants.main,
      );
  }
}