import 'package:firebase_analytics/firebase_analytics.dart';
/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/components/buttons/google_signin_button_wrapper.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
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

  _FavouritesScreenState()
  {
    FirebaseAnalytics().logEvent(name: 'open_screen', parameters: {'Screen': 'Favourites'} );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: Constants.fontFamily,
      ),
      child: Scaffold(
        backgroundColor: Constants.background,
        body: FutureBuilder<List<Recipe>>(
          future: _recipeService.getFavouriteRecipes( Constants.appUser ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) 
            {
              return snapshot.hasError ?
                SnackBarUtil.createTextSnackBar( Localization.instance.language.getMessage( 'recipe_database_error' ) ) :
                Theme(
                  data: Constants.themeData,
                  child: ! Constants.appUser.isLoggedIn() ?
                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            Localization.instance.language.getMessage( '' ),
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
                            Localization.instance.language.getMessage( 'no_bookmarks_yet' ),
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
      ),
    );
  }
}