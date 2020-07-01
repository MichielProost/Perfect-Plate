import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/general/icon_builder.dart';
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

  // TODO remove placeholder steps
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

  // TODO remove if no longer needed
  // Widget buildStepWidget(int stepIndex, String stepDescription) {
  //   return Card(
  //     child: Row(
  //       children: <Widget>[
  //         Text(
  //           stepIndex.toString(),
  //           style: TextStyle(
  //             fontSize: 150.0,
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 15.0),
  //           child: Container(
  //             width: 1.0,
  //             height: double.infinity,
  //             color: Colors.black,
  //           ),
  //         ),
  //         Text(
  //           stepDescription,
  //           textAlign: TextAlign.justify,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Generate the banner for this recipe
  Widget buildBanner() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        // Image component
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            height: 140.0,
            width: double.infinity,
            child: Image(image: NetworkImage(_recipe.image), fit: BoxFit.fitWidth),
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
              shadows: <Shadow>[
                Shadow(blurRadius: 10.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a Widget that contains an introduction text
  Widget buildIntroText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Text(
        _recipe.description,
        textAlign: TextAlign.justify,
      ),
    );
  }

  /// Build an information icon with one-word description which gets enabled/disabled colors
  Widget buildIconInfoCustom(CustomIcon icon, String text, bool isTrue) {
    Color color = isTrue ? Constants.green : Constants.gray;
    return buildIconInfoByIcon(IconBuilder(icon, color: color), text, color);
  }

  /// Build an information icon with one-word description which gets enabled/disabled colors
  Widget buildIconInfo(IconData icon, String text, bool isTrue) {
    Color color = isTrue ? Constants.green : Constants.gray;
    return buildIconInfoByIcon(Icon(icon, color: color), text, color);
  }

  /// Build an information icon with one-word description which gets enabled/disabled colors
  Widget buildIconInfoByIcon(Widget icon, String text, Color textColor) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: icon,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    );
  }

  /// Creates an info panel about this recipe
  /// Indicates properties
  Widget buildInfoPanel() {
    return Column(
      children: <Widget>[
        Container(
          height: 1.0,
          width: double.infinity,
          color: Constants.gray,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildIconInfo(Icons.fastfood, _recipe.getReadableType(), true),
                  buildIconInfoCustom(CustomIcon.vegetarian, "Vegetarian", _recipe.isVegetarian),
                ],
              ),
              SizedBox(
                width: 50.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildIconInfo(Icons.timer, _recipe.duration.toString() + "''", true),
                  buildIconInfoCustom(CustomIcon.vegan, "Vegan", _recipe.isVegan),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1.0,
          width: double.infinity,
          color: Constants.gray,
        ),
      ],
    );
  }

  /// Creates a list of ingredients for this recipe
  Widget buildIngredients() {
    //TODO add ingredient list
  }

  /// Create an ExpansionTile for the step with given index
  Widget buildExpansionTile(int index) {
    // TODO add language support
    return Theme(
      data: ThemeData(
        accentColor: Constants.main,
      ),
      child: ExpansionTile(
        title: Text(
          "Step " + (index + 1).toString(),
          style: TextStyle(
            color: Constants.main,
          ),
        ),
        initiallyExpanded: true,
        children: <Widget>[
          Text(
            _recipe.stepDescriptions[index],
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          //Image(),
          SizedBox(
            height: 15.0,
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
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.info_outline,
                  //     size: 35.0,
                  //   ),
                  //   // TODO add proper language system
                  //   onPressed:  () => showDialog(context: context, child: InfoPopup("Description", _recipe.description, Icons.info_outline)),
                  // ),

                  // TODO implement timer
                  // Timer button
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.timer,
                  //     size: 35.0,
                  //   ),
                  //   onPressed: () {
                  //     // TODO add timer
                  //   },
                  // ),

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
                      }),

                  // Provide space between icons
                  Expanded(
                    child: SizedBox(
                      height: 1.0,
                      width: 1.0,
                    ),
                  ),

                  // Close recipe button
                  IconButton(
                    icon: Icon(Icons.close, size: 35.0),
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                  ),
                ],
              ),

              // Scrollable recipe
              Expanded(
                child: ListView(shrinkWrap: true, children: <Widget>[
                  // Recipe title banner
                  buildBanner(),
                  buildIntroText(),
                  buildInfoPanel(),
                  // Show all steps
                  for (int stepNumber = 0; stepNumber < _recipe.stepDescriptions.length; stepNumber++) buildExpansionTile(stepNumber),
                ]),
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
