import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/popup/create_recipe_card.dart';
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

          FirebaseAnalytics().logEvent(name: 'add_button_pressed', parameters: {'is_logged_in': Constants.appUser.isLoggedIn()} ),

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