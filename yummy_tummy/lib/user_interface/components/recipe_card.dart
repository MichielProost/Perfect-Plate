import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/popup/recipe_page.dart';
import 'package:yummytummy/user_interface/popup/snackbar_util.dart';

import '../constants.dart';
import 'rating_row.dart';

class RecipeCard extends StatefulWidget {
  
  final Recipe _recipe;
  final bool _showBookmark;
  final bool _showNumReviews;
  bool _value;

  RecipeCard(this._recipe, {bool showBookmark: false, bool showNumReviews: false}): 
    _showBookmark = showBookmark,
    _showNumReviews = showNumReviews;

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
                          // TODO implement language system
                          String text = _isBookMarked ? 'This recipe will not be deleted' : 'This recipe will be deleted soon. Press the save button again to undo this action.';
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
                    Text( RankType.dishwasher.getRank( _recipe.userMap['rank'] ).getString() ),
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