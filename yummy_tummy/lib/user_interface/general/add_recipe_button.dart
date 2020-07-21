import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/popup/create_recipe_card.dart';
import 'package:yummytummy/user_interface/popup/recipe_page.dart';

import '../constants.dart';

class AddRecipeButton extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      child: FloatingActionButton(
        onPressed: () => {
          showDialog(context: context, child: CreateRecipeCard())
        },
        child: Icon(
          Icons.add,
          size: 30.0,
        ),
        backgroundColor: Constants.main,
      ),
    );
  }
}