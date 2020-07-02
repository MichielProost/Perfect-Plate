/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/dummy/dummydatabase.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/waiting_indicator.dart';

import 'components/recipe_card.dart';
import 'constants.dart';

class FeedScreen extends StatelessWidget {

  final RecipeService _recipeService = DummyDatabase(delayInMilliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        //TODO replace by feed algorithm
        future: _recipeService.getRecipesFromUser(UserMapField.id, 'id'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) 
          {
            return ListView(
              children: <Widget>[
                for (Recipe recipe in snapshot.data) RecipeCard(recipe, showBookmark: false),
              ],
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