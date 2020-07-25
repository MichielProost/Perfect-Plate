import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/popup/create_recipe_card.dart';
import 'package:yummytummy/user_interface/popup/recipe_page.dart';
import 'package:yummytummy/user_interface/popup/snackbar_util.dart';

import '../constants.dart';

class AddRecipeButton extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      child: FloatingActionButton(
        onPressed: () => {
          Constants.appUser.isLoggedIn() ?
          showDialog(context: context, child: CreateRecipeCard()) :
          SnackBarUtil.showTextSnackBar(context, "You have to be logged in to create a recipe!")
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