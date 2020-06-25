import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:yummytummy/model/recipe.dart';

import '../constants.dart';

class RecipePage extends StatefulWidget {
  
  final Recipe _recipe;

  RecipePage(this._recipe);

  @override
  State<StatefulWidget> createState() => _RecipePageState(_recipe);
  
}

class _RecipePageState extends State<RecipePage> {
  
  final Recipe _recipe;
  //TODO properly implement favourite
  bool _isFavorite = false;

  _RecipePageState(this._recipe);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 60.0, bottom: 5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[

              // Button bar for user
              Row(
                children: <Widget>[
                  
                  // Timer button
                  IconButton(
                    icon: Icon(
                      Icons.timer,
                      size: 35.0,

                    ), 
                    onPressed: () {
                      // TODO add timer
                    },
                  ),

                  // Share button
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 35.0,

                    ), 
                    onPressed: () {
                      // TODO implement actual share logic
                      //Share.share( _recipe.getId() );
                    },
                  ),

                  // Bookmark button
                  IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.bookmark : Icons.bookmark_border,
                      size: 35.0,
                    ), 
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                      //TODO add favourite/unfavourite logic
                    }
                  ),

                  // Provide space between icons 
                  Expanded(
                    child: SizedBox(
                      height: 1.0,
                      width: 1.0,
                    ),
                  ),

                  // Close recipe button
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 35.0
                    ),
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                  ),
                ],
              ),

              // Recipe title banner
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[

                  // Image component
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      height: 140.0,
                      width: double.infinity,
                      child: Image(
                        image: NetworkImage(_recipe.image),
                        fit: BoxFit.fitWidth
                      ),
                    ),
                  ),

                  // Text component
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      _recipe.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27.0,
                        //backgroundColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow> [
                          Shadow(
                            blurRadius: 10.0
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Recipe description
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  _recipe.description,
                  textAlign: TextAlign.justify,
                ),
              ),

              // TODO add recipe info: vegetarian, vegan, dish type (salad), 

              // Separator line
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),

              // Recipe info: ingrediënts and steps
              Expanded(
                child: Container(
                  color: Colors.red,
                  child: ListView(
                    children: <Widget>[
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}