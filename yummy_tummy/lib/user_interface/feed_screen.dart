/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/dummy/dummydatabase.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/query/queryInfo.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/waiting_indicator.dart';
import 'package:yummytummy/user_interface/popup/snackbar_util.dart';

import 'components/recipe_card.dart';
import 'constants.dart';

class FeedScreen extends StatelessWidget {

  final RecipeService _recipeService = RecipeServiceFirestore();

  @override
  Widget build(BuildContext context) {

    RecipeQuery queryInfo = RecipeQuery();

    return Scaffold(
      backgroundColor: Constants.background,
      body: FutureBuilder<RecipeQuery> (
        //TODO replace by feed algorithm
        future: _recipeService.searchRecipes(queryInfo, SortField.weightedRating, DietField.any, RecipeType.any, List<String>()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) 
          {
            return snapshot.hasError ?
              //TODO implement language
              SnackBarUtil.createTextSnackBar("An error occured while retrieving the recipes!") :
              Theme(
                data: Constants.themeData,
                child: ListView(
                  children: <Widget>[
                    
                    if (snapshot.data.recipes.length == 0)
                      Padding(
                        padding: const EdgeInsets.only( top: 20.0 ),
                        child: Text(
                          "Woops, no recipes found! :-(",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    for (Recipe recipe in snapshot.data.recipes) 
                      RecipeCard(recipe, showBookmark: false, showNumReviews: true,),

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