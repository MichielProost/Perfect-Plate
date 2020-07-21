import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/storage/storageHandler.dart';
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

enum ImageInput {
  camera,
  gallery,
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

  final StorageHandler imageHandler = StorageHandler();

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
                        // _titleKey.currentState.clearTextField();
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
                Column(
                  children: <Widget>[
                    ChooseImageIcon(
                      heigth: 100.0,
                      width: 200.0,
                      image: _banner,
                      size: 50.0,
                      callback: (tapLocation) {
                        
                        double left;
                        double top;
                        if (tapLocation != null)
                        {
                          left = tapLocation.dx;
                          top = tapLocation.dy;
                        }
                        else
                        {
                          left = MediaQuery.of(context).size.width / 3;
                          top = MediaQuery.of(context).size.height / 3;
                        }
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(left, top, MediaQuery.of(context).size.width - left, MediaQuery.of(context).size.height - top),
                          items: <PopupMenuEntry>[
                            PopupMenuItem(
                              value: ImageInput.camera,
                              child: InkWell(
                                child: Text("Camera"),
                                onTap: () async {
                                  File selected = await imageHandler.getPicture( ImageSource.camera );
                                  setState(() {
                                    if (selected != null)
                                      _banner = selected;
                                  });
                                },
                              ),
                            ),
                            PopupMenuItem(
                              value: ImageInput.gallery,
                              child: InkWell(
                                child: Text("Gallery"),
                                onTap: () async {
                                  File selected = await imageHandler.getPicture( ImageSource.gallery );
                                  setState(() {
                                    if (selected != null)
                                      _banner = selected;
                                  });
                                },
                              ),
                            ),
                          ]
                        );
                      },
                    ),
                  ],
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
                      hint: _description == null ? "Set the recipe's description here" : '[Description] ' + _description,
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
                        // _descriptionkey.currentState.clearTextField();
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

            Padding(
              padding: const EdgeInsets.symmetric( vertical: 8.0 ),
              child: Text(
                "Ingredients",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
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

            Padding(
              padding: const EdgeInsets.symmetric( vertical: 8.0 ),
              child: Text(
                "Step descriptions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Step adder with image option
            for (int step = 0; step < _steps.length + 1; step++)
              buildStepDisplay( step ),

          ],
        ),
      ),
    );
  }

  Widget buildStepDisplay(int index)
  {
    final GlobalKey<CustomTextFieldState> key = GlobalKey();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Constants.gray,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      maxLines: 3,
                      hint: _steps.length > index ? _steps[index] : "Add step info here",
                      key: key,
                      callback: (value) {
                        // if (index >= _steps.length)
                        //   _steps.add( value );
                        // else
                        //   _steps[ index ] = value;
                      },
                    ),
                  ),
                ),
                if (index < _steps.length)
                IconButton(
                  icon: Icon(Icons.delete), 
                  onPressed: () {
                    setState(() {
                      if ( _steps.length > index )
                        _steps.removeAt( index );
                      if ( _images.length > index )
                        _images.removeAt( index );
                    });
                  }
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  
                  ChooseImageIcon(
                    heigth: 100.0,
                    width: 100.0,
                    size: 25.0,
                  ),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ActionButton(
                        index == _steps.length ? "Add step" : "Update step",
                        onClick: () {
                          setState(() {
                            if (index >= _steps.length) {
                              _steps.add( key.currentState.getCurrentText() );
                              _images.add( File("") );
                            } 
                            else
                            {
                              _steps[ index ] = key.currentState.getCurrentText();
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
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