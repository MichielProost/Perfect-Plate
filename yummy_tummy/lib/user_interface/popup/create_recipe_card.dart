import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/components/action_button.dart';
import 'package:yummytummy/user_interface/components/choose_image_icon.dart';
import 'package:yummytummy/user_interface/components/custom_textfield.dart';

import '../constants.dart';

class CreateRecipeCard extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _CreateRecipePage();
  }

}

class _CreateRecipePage extends State<CreateRecipeCard> {

  // Create recipe util
  List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final GlobalKey<CustomTextFieldState> _titleKey = new GlobalKey();
  final GlobalKey<CustomTextFieldState> _descriptionkey = new GlobalKey();
  final GlobalKey<CustomTextFieldState> _addIngredientKey = new GlobalKey();
  final List<GlobalKey<CustomTextFieldState>> _stepKeys = [];

  // Data holders
  String _title;
  File _banner;
  String _description;
  DietField _dietField = DietField.any;
  RecipeType _recipeType = RecipeType.any;
  int _preptime = 15;
  List<String> _ingredients = List<String>();
  List<String> _steps = List<String>();
  List<File> _images = List<File>();

  final List<int> _times = List<int>();

  _CreateRecipePage()
  {
    for (int i = 15; i <= 180; i += 15)
      _times.add( i );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[


            // Create recipe text
            Padding(
              padding: const EdgeInsets.only( top: 8.0, left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Create new recipe",
                    textAlign: TextAlign.center,
                    style: Constants.emptyScreenStyle,
                  ),
                  CloseButton(),
                ],
              ),
            ),


            // Recipe title input
            Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                    child: CustomTextField(
                      key: _titleKey,
                      hint: this._title == null ? "Set the recipe's title here" : '[Title] ' + this._title,
                      maxLines: 1,
                      callback: (content) {
                        setState(() {
                          _title = content;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ActionButton(
                    "Set", 
                    width: 50.0,
                    onClick: () {
                      setState(() {
                        _title = _titleKey.currentState.getCurrentText();
                        _titleKey.currentState.clearTextField();
                      });
                      FocusScope.of(context).unfocus();
                    },
                  ),
                )
              ],
            ),


            // Banner image input
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ChooseImageIcon(
                  heigth: 100.0,
                  width: 200.0,
                  size: 50.0,
                  infoText: "Set banner image",
                  callback: () {

                  },
                ),
              ],
            ),


            // Description input
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                    child: CustomTextField(
                      key: _descriptionkey,
                      hint: "Set the recipe's description here",
                      maxLines: 10,
                      callback: (content) {
                        setState(() {
                          _description = content;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ActionButton(
                    "Set", 
                    width: 50.0,
                    onClick: () {
                      setState(() {
                        _description = _descriptionkey.currentState.getCurrentText();
                        _descriptionkey.currentState.clearTextField();
                      });
                      FocusScope.of(context).unfocus();
                    },
                  ),
                )
              ],
            ),


            // Info selection: recipe type, diet type, duration
            Align(
              alignment: Alignment.centerLeft,
              child: GridView.count(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                childAspectRatio: 4.0 / 1.0,
                crossAxisCount: 2,
                children: <Widget>[
                  
                  // Text label
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Diet of this recipe")
                    ),
                  ),

                  // Diet chooser: vegetarian, vegan, ...
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: DropdownButton<DietField>(
                      value: _dietField,
                      icon: Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      onChanged: (DietField newValue) {
                        setState(() {
                          _dietField = newValue;
                        });
                      },
                      items: DietField.values
                          .map<DropdownMenuItem<DietField>>((DietField value) {
                        return DropdownMenuItem<DietField>(
                          value: value,
                          child: Text( value == DietField.any ? "Set the diet" : value.getString() ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Text label
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Type of dish")
                    ),
                  ),

                  // Recipe type: main, salad, dessert, ...
                  Padding(
                    padding: const EdgeInsets.only( right: 50.0 ),
                    child: DropdownButton<RecipeType>(
                      value: _recipeType,
                      icon: Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      onChanged: (RecipeType newValue) {
                        setState(() {
                          _recipeType = newValue;
                        });
                      },
                      items: RecipeType.values
                          .map<DropdownMenuItem<RecipeType>>((RecipeType value) {
                        return DropdownMenuItem<RecipeType>(
                          value: value,
                          child: Text(value == RecipeType.any ? "Set recipe type" : value.getString()),
                        );
                      }).toList(),
                    ),
                  ),

                  // Text label
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Preparation time (minutes)")
                    ),
                  ),

                  // Recipe type: main, salad, dessert, ...
                  Padding(
                    padding: const EdgeInsets.only( right: 50.0 ),
                    child: DropdownButton<String>(
                      value: _preptime.toString(),
                      icon: Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      onChanged: (String newValue) {
                        setState(() {
                          _preptime = int.parse( newValue );
                        });
                      },
                      items: _times.map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),

                ],
              ),
            ),


            // Ingredients adder
            Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                    child: CustomTextField(
                      key: _addIngredientKey,
                      hint: "Add an ingredient here",
                      maxLines: 1,
                      callback: (content) {
                        setState(() {
                          _ingredients.add( content );
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ActionButton(
                    "Add", 
                    width: 50.0,
                    onClick: () {
                      setState(() {
                        _ingredients.add(_addIngredientKey.currentState.getCurrentText());
                        _addIngredientKey.currentState.clearTextField();
                      });
                      FocusScope.of(context).unfocus();
                    },
                  ),
                )
              ],
            ),


            // Ingredient display and remover
            Container(
              height: (_ingredients.length * 60 > 150 ? 150 : _ingredients.length * 60).toDouble(),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  // Display selected recipes
                  for (int i = 0; i < _ingredients.length; i++)
                    buildIngredientDisplay(i)
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChooseImageIcon(
                    heigth: 50.0,
                    width: 50.0,
                    size: 25.0,
                  ),
                ),
              ],
            ),

            // Step adder with image option
            // for (int step = 0; step < steps)

          ],
        ),
      ),
    );
  }


  Widget buildIngredientDisplay(int index)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Constants.gray,
        child: Padding(
          padding: const EdgeInsets.only(left: 60.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _ingredients[index],
              ),
              IconButton(
                icon: Icon(Icons.delete), 
                onPressed: () {
                  setState(() {
                    _ingredients.removeAt( index );
                  });
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

}