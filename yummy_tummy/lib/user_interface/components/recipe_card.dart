import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
import 'package:yummytummy/user_interface/popup/action_popup.dart';
import 'package:yummytummy/user_interface/popup/info_popup.dart';
import 'package:yummytummy/user_interface/popup/recipe_page.dart';
import 'package:yummytummy/user_interface/popup/snackbar_util.dart';

import '../constants.dart';
import 'rating_row.dart';

class RecipeCard extends StatefulWidget {
  
  final Recipe _recipe;
  final bool _showBookmark;
  final bool _showNumReviews;
  final bool _isDeleteAble;

  RecipeCard(this._recipe, {bool showBookmark: false, bool showNumReviews: false, bool canBeDeleted: false}): 
    _showBookmark = showBookmark,
    _showNumReviews = showNumReviews,
    _isDeleteAble = canBeDeleted;

  @override
  State<StatefulWidget> createState() => _RecipeCardState(_recipe, showBookmark: _showBookmark);

}

class _RecipeCardState extends State<RecipeCard> {
  
  final Recipe _recipe;
  final bool _showBookmark;
  bool _isBookMarked = true;

  /// Create a recipe Card that contains all info of the provided recipe
  /// Showbookmark will decide whether or not to display the bookmark icon
  _RecipeCardState(this._recipe, {bool showBookmark: false}): _showBookmark = showBookmark {
    _isBookMarked = Constants.appUser.favourites.contains( _recipe.id );
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () => showDialog(context: context, child: RecipePage(_recipe)),
        onLongPress: () {
          if (widget._isDeleteAble)
            showDialog(
              context: context,
              child: ActionPopup(
                icon: Icons.report,
                title: Localization.instance.language.getMessage( 'delete_recipe_title' ),
                text: Localization.instance.language.getMessage( 'delete_recipe_warning' ),
                onAccept: () {
                  RecipeServiceFirestore().deleteRecipe( _recipe.id );
                },
              ),  
            );
        },
        child: Card(
          color: Constants.gray,
          shape: _recipe.userMap.containsKey('id') && _recipe.userMap['id'] == Constants.magnetarID && false
          ? new RoundedRectangleBorder(
              side: new BorderSide(color: Constants.main, width: 2.0),
              borderRadius: BorderRadius.circular(8.0))
          : new RoundedRectangleBorder(
              side: new BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _recipe.title,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (_showBookmark)
                      InkWell(
                        onTap: () {

                          UserService database = UserServiceFirestore();

                          // Modify app user.
                          if(_isBookMarked){
                            Constants.appUser.favourites.remove(_recipe.id);
                          } else {
                            Constants.appUser.favourites.add(_recipe.id);
                          }

                          // Modify user document.
                          database.modifyUser(Constants.appUser, Constants.appUser.id);

                          setState(() {
                            _isBookMarked = !_isBookMarked;
                          });
                          String text = _isBookMarked ? 
                            Localization.instance.language.getMessage( 'undo_unfavourite' ) : 
                            Localization.instance.language.getMessage( 'unfavourite' );
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(SnackBarUtil.createTextSnackBar(text));
                        },
                        child: Icon(
                          _isBookMarked ? Icons.bookmark : Icons.bookmark_border,
                          size: 40.0,
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    widget._showNumReviews ?
                      RatingRow(_recipe.rating, _recipe.numberOfReviews) :
                      RatingRow(_recipe.rating),
                    Text(
                      Localization.instance.language.rankName( RankType.dishwasher.getRank( _recipe.userMap['rank'] ) ) 
                    ),
                    Text( _recipe.userMap['name'] ),
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
                        image: NetworkImage(_recipe.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          _recipe.description,
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
      ),
    );
  }

}