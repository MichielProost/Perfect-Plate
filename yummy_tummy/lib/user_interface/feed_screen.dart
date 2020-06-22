/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/utils/storeData.dart';

import 'components/recipe_card.dart';

class FeedScreen extends StatelessWidget {

  final List<Recipe> _recipes = getRecipes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          for (Recipe recipe in _recipes) RecipeCard(recipe, showBookmark: false),
        ],
      ),
    );
  }

}