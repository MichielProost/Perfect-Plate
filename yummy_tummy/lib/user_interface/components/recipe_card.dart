import 'package:flutter/material.dart';
import 'package:yummytummy/model/recipe.dart';

class RecipeCard extends StatelessWidget {
  
  final Recipe _recipe;
  final bool _showBookmark;

  /// Create a recipe Card that contains all info of the provided recipe
  /// Showbookmark will decide whether or not to display the bookmark icon
  RecipeCard(this._recipe, {bool showBookmark: false}): _showBookmark = showBookmark;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Text(_recipe.getTitle()),
            Row(
              
            ),
          ],
        ),
      ),
    );
  }

}