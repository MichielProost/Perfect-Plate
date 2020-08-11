import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/user_interface/components/rating_row.dart';
import 'package:yummytummy/user_interface/components/text/TimeAgoText.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
import 'package:yummytummy/user_interface/popup/recipe_page.dart';

import '../constants.dart';

class ReviewCard extends StatefulWidget {
  
  final Review _review;
  final bool allowRecipeLink;
  
  ReviewCard(this._review, {this.allowRecipeLink: false});
  
  @override
  State<StatefulWidget> createState() {
    return _Card();
  }
}

class _Card extends State<ReviewCard> {
  
  void _handleOpenRecipe(BuildContext context) async
  {
    if (widget.allowRecipeLink)
    {
      Recipe recipe = await RecipeServiceFirestore().getRecipeFromID( widget._review.recipeID );
      showDialog(context: context, child: RecipePage(recipe));
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    Theme(
      data: ThemeData(
        fontFamily: Constants.fontFamily,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          child: InkWell(
            onTap: () => _handleOpenRecipe(context),
            enableFeedback: widget.allowRecipeLink,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      // Recipe rating
                      RatingRow.withSize(
                        widget._review.rating.toDouble(),
                        size: 23.0,
                      ),

                      // User name
                      Text( 
                        widget._review.user.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      
                      TimeAgoText(widget._review.timestamp ?? Timestamp.now()),

                      // User rank
                      Text(
                        Localization.instance.language.rankName( widget._review.user.rank ),
                      ),
                    ],
                  ),

                  // Description
                  if (widget._review.description.length != 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                    child: Text( 
                      widget._review.description 
                    ),
                  ),
                ],
              ),
            ),
          ),
          color: Constants.gray,
        ),
      ),
    );
  }
}