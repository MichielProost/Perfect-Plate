import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/popup/recipe_page.dart';

import '../constants.dart';

class AddRecipeButton extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      child: FloatingActionButton(
        onPressed: () => {},
        child: Icon(
          Icons.add,
          size: 30.0,
        ),
        backgroundColor: Constants.main,
      ),
    );
  }
}