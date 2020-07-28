/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/buttons/google_signin_button_wrapper.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/popup/snackbar_util.dart';

import 'components/recipe_card.dart';
import 'components/waiting_indicator.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavouritesScreenState();
  }

}

class _FavouritesScreenState extends State<FavouritesScreen> {

  RecipeService _recipeService = RecipeServiceFirestore();

  @override
  Widget build(BuildContext context) {
    Constants;
    return Scaffold(
      backgroundColor: Constants.background,
      body: FutureBuilder<List<Recipe>>(
        future: _recipeService.getFavouriteRecipes( Constants.appUser ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) 
          {
            return snapshot.hasError ?
              //TODO implement language
              SnackBarUtil.createTextSnackBar("An error occured while retrieving the recipes!") :
              Theme(
                data: Constants.themeData,
                child: ! Constants.appUser.isLoggedIn() ?
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Please log in to see your saved recipes!',
                          textAlign: TextAlign.center,
                          style: Constants.emptyScreenStyle,
                        ),
                        GoogleSigninButtonWrapper(
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ) : 
                ListView(
                  children: <Widget>[
                    
                    if (snapshot.data.length == 0)
                      Padding(
                        padding: const EdgeInsets.only( top: 8.0 ),
                        child: Text(
                          'You have no favourites yet.\nBookmark a recipe to save it to this screen.',
                          textAlign: TextAlign.center,
                          style: Constants.emptyScreenStyle,
                        ),
                      ),

                    for (Recipe recipe in snapshot.data) 
                      RecipeCard(recipe, showBookmark: true, showNumReviews: true,),

                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              );
          } 
          else
          {
            return WaitingIndicator();
          }
        },
      ), 
    );
  }
}