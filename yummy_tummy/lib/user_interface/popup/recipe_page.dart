import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/popup/info_popup.dart';

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
  List<String> steps = [
    "Pak een kommeke",
    "Pak een aantal ingrediëntekes klaar", 
    "Haal ze uit hun verpakkingskes",
    "Klets die bij mekaar in een kommeke",
    "Doe beetje mengen enzo",
    "Duw da in de oven",
    "En kleir"
  ];

  _RecipePageState(this._recipe);

  Widget buildStepWidget(int stepIndex, String stepDescription)
  {
    return Card(
      child: Row(
        children: <Widget>[
          Text(
            stepIndex.toString(),
            style: TextStyle(
              fontSize: 150.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: 1.0,
              height: double.infinity,
              color: Colors.black,
            ),
          ),
          Text(
            stepDescription,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 60.0, bottom: 5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              // Button bar for user
              Row(
                children: <Widget>[
                  
                  IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      size: 35.0,
                    ),
                    // TODO add proper language system
                    onPressed:  () => showDialog(context: context, child: InfoPopup("Description", _recipe.getDescription(), Icons.info_outline)),
                  ),

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
                        image: NetworkImage(_recipe.getImageURL()),
                        fit: BoxFit.fitWidth
                      ),
                    ),
                  ),

                  // Text component
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

              // TODO add recipe info: vegetarian, vegan, dish type (salad), 

              // Recipe info: ingrediënts and steps
              //  Container(
              //    height: MediaQuery.of(context).size.height,
              //    width: MediaQuery.of(context).size.width,
              //    child: ListWheelScrollView(
              //       itemExtent: 3,
              //       children: <Widget>[
              //         for (int i= 0; i < steps.length; i++)
              //           Text("Placeholder"),
              //           //buildStepWidget(i, steps[i]),
              //       ],
              //     ),
              //  ),
            ],
          ),
        ),
      ),
    );
  }

}