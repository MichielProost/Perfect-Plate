/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/dummy/dummydatabase.dart';
import 'package:yummytummy/model/recipe.dart';

import 'components/recipe_card.dart';

class FeedScreen extends StatelessWidget {

  // TODO implement a recipe selection algorithm
  final List<Recipe> _recipes = DummyDatabase().getRecipes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          for (Recipe recipe in _recipes) RecipeCard(recipe, showBookmark: false),
        ],
      ),
    );
  }

}