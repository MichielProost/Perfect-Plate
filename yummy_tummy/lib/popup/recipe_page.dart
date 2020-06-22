import 'package:flutter/material.dart';
import 'package:yummytummy/model/recipe.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  
                  IconButton(
                    icon: Icon(
                      Icons.timer,
                      size: 35.0,

                    ), 
                    onPressed: () {
                      // TODO add timer
                    },
                  ),

                  // Button to bookmark/unmark
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

                  // Icon button to close the menu
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
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      height: 140.0,
                      width: double.infinity,
                      child: Image(
                        image: NetworkImage(_recipe.getImageURL()),
                        fit: BoxFit.fitWidth
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      _recipe.getTitle(),
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
            ],
          ),
        ),
      ),
    );
  }

}