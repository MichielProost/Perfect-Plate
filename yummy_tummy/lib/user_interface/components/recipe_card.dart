import 'package:flutter/material.dart';
import 'package:yummytummy/model/recipe.dart';

import '../constants.dart';
import 'rating_row.dart';

class RecipeCard extends StatelessWidget {
  
  final Recipe _recipe;
  final bool _showBookmark;

  /// Create a recipe Card that contains all info of the provided recipe
  /// Showbookmark will decide whether or not to display the bookmark icon
  RecipeCard(this._recipe, {bool showBookmark: false}): _showBookmark = showBookmark;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Constants.gray,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _recipe.getTitle(),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (_showBookmark)
                  Icon(
                    Icons.bookmark,
                    size: 40.0,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  RatingRow(_recipe.getRating()),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 140.0,
                    height: 140.0,
                    child: Image(
                      image: NetworkImage(_recipe.getImageURL()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        _recipe.getDescription(),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}