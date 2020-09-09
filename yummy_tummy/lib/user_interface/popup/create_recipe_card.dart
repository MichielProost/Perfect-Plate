import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/storage/storageHandler.dart';
import 'package:yummytummy/user_interface/components/action_button.dart';
import 'package:yummytummy/user_interface/components/choose_image_icon.dart';
import 'package:yummytummy/user_interface/components/custom_textfield.dart';
import 'package:yummytummy/user_interface/components/error_card.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

import '../constants.dart';
import 'info_popup.dart';

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

  // State info
  bool scrollToTop = true;

  // Create recipe util
  GlobalKey<CustomTextFieldState> _titleKey = new GlobalKey();
  GlobalKey<CustomTextFieldState> _descriptionkey = new GlobalKey();
  GlobalKey<CustomTextFieldState> _addIngredientKey = new GlobalKey();
  static List<GlobalKey<CustomTextFieldState>> stepKeys = List<GlobalKey<CustomTextFieldState>>();

  final ScrollController _controller = ScrollController();
  final StorageHandler imageHandler = StorageHandler();

  List<String> _errors = List<String>();

  // Data holders
  LanguagePick _languagePick = Constants.appUser.languagePreference;
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

  void _scrollToBottom()
  {
    _controller.jumpTo( _controller.position.maxScrollExtent );
  }

  @override
  Widget build(BuildContext context) {

    if (scrollToTop)
      SchedulerBinding.instance.addPostFrameCallback((_){ _scrollToBottom(); });

    scrollToTop = false;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            
            // Create recipe text
            Padding(
              padding: const EdgeInsets.only( top: 8.0, left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    Localization.instance.language.getMessage( 'create_recipe' ),
                    textAlign: TextAlign.center,
                    style: Constants.emptyScreenStyle,
                  ),
                  CloseButton(),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                controller: _controller,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  // controller: _controller,
                  shrinkWrap: true,
                  children: <Widget>[
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: 4.0 / 1.0,
                        crossAxisCount: 2,
                        children: <Widget>[

                          // Select language text
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(Localization.instance.language.getMessage( 'select_language' )),
                            ),
                          ),

                          // Language dropdown
                          DropdownButton<LanguagePick>(
                            value: _languagePick,
                            icon: Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            onChanged: (LanguagePick newValue) {
                              setState(() {
                                _languagePick = newValue;
                              });
                            },
                            items: 
                            LanguagePick.values.map<DropdownMenuItem<LanguagePick>>(
                              (LanguagePick value) {
                                return DropdownMenuItem<LanguagePick>(
                                  value: value,
                                  child: Text(value != LanguagePick.other ? Localization.instance.language.languageName( value ) : Localization.instance.language.getMessage( 'select_language' )),
                                );
                              }
                            ).toList(),
                          ),
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
                              startValue: _title ?? "",
                              hint: this._title == null ? 
                                Localization.instance.language.getMessage( 'choose_title_here' ) : 
                                '[' + Localization.instance.language.getMessage( 'title' ) + '] ' + this._title,
                              maxLines: 1,
                              onChanged: (String text) {
                                _title = text;
                              },
                              callback: (String content) {
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
                            Localization.instance.language.getMessage( 'set' ), 
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
                              callback: (tapLocation) async {
                                
                                File selected = await imageHandler.getPicture();
                                setState(() {
                                  if (selected != null)
                                    _banner = selected;
                                });

                                // double left;
                                // double top;
                                // if (tapLocation != null)
                                // {
                                //   left = tapLocation.dx;
                                //   top = tapLocation.dy;
                                // }
                                // else
                                // {
                                //   left = MediaQuery.of(context).size.width / 3;
                                //   top = MediaQuery.of(context).size.height / 3;
                                // }
                                // showMenu(
                                //   context: context,
                                //   position: RelativeRect.fromLTRB(left, top, MediaQuery.of(context).size.width - left, MediaQuery.of(context).size.height - top),
                                //   items: <PopupMenuEntry>[
                                //     PopupMenuItem(
                                //       enabled: false,
                                //       child: ListTile(
                                //         title: Text( Localization.instance.language.getMessage( 'camera' ) ),
                                //         onTap: () async {
                                //           File selected = await imageHandler.getPicture(  );
                                //           setState(() {
                                //             if (selected != null)
                                //               _banner = selected;
                                //           });
                                //         },
                                //       ),
                                //     ),
                                //     PopupMenuItem(
                                //       enabled: false,
                                //       child: ListTile(
                                //         title: Text( Localization.instance.language.getMessage( 'gallery' ) ),
                                //         onTap: () async {
                                //           File selected = await imageHandler.getPicture(  );
                                //           setState(() {
                                //             if (selected != null)
                                //               _banner = selected;
                                //           });
                                //         },
                                //       ),
                                //     ),
                                //   ]
                                // );
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
                              startValue: _description ?? "",
                              hint: _description == null ? 
                                Localization.instance.language.getMessage( 'description_here' ) : 
                                '[' + Localization.instance.language.getMessage( 'description' ) + '] ' + _description,
                              maxLines: 10,
                              onChanged: (String text) {
                                _description = text;
                              },
                              callback: (String content) {
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
                            Localization.instance.language.getMessage( 'set' ), 
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
                              child: Text( Localization.instance.language.getMessage( 'select_diet' ) )
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
                                  child: Text( value == DietField.any ? 
                                    Localization.instance.language.getMessage( 'none' ) : 
                                    Localization.instance.language.dietFieldName( value ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          // Text label
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text( Localization.instance.language.getMessage( 'select_course' ) )
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
                                  child: Text(value == RecipeType.any ? 
                                    Localization.instance.language.getMessage( 'set_course' ) : 
                                    Localization.instance.language.recipeTypeName( value ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          // Text label
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text( Localization.instance.language.getMessage( 'preparation_time' ) )
                            ),
                          ),

                          // Duration selection
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
                                  child: Text(
                                    (value / 60).floor().toString() + Localization.instance.language.getMessage( 'hour_unit' ) + 
                                    (value % 60).toString() + Localization.instance.language.getMessage( 'minute_unit' ),
                                  ),
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
                        Localization.instance.language.getMessage( 'ingredients' ),
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
                              hint: Localization.instance.language.getMessage( 'add_ingredient_hint' ),
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
                            Localization.instance.language.getMessage( 'add' ), 
                            width: 50.0,
                            onClick: () {
                              setState(() {
                                _ingredients.add( _addIngredientKey.currentState.getCurrentText() );
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
                        Localization.instance.language.getMessage( 'step_descriptions' ),
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


                    for (String error in _errors)
                      ErrorCard( error ),

                    // Submit button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
                      child: ActionButton(
                        Localization.instance.language.getMessage( 'submit' ),
                        onClick: () async {
                          _errors = List<String>();

                          if (_title == null || _title == "")
                            _errors.add(
                              Localization.instance.language.getMessage( 'error_no_title' )
                            );

                          if (_banner == null)
                            _errors.add(
                              Localization.instance.language.getMessage( 'error_no_banner' )
                            );

                          if (_description != null && _description.length < 15)
                            _errors.add(
                              Localization.instance.language.getMessage( 'error_short_descr' )
                            );

                          if (_recipeType == RecipeType.any)
                            _errors.add(
                              Localization.instance.language.getMessage( 'error_no_type' )
                            );

                          if (_ingredients.length == 0)
                            _errors.add(
                              Localization.instance.language.getMessage( 'error_no_ingredients' )
                            );

                          if (_steps.length == 0)
                            _errors.add(
                              Localization.instance.language.getMessage( 'error_no_steps' )
                            );

                          if (_languagePick == LanguagePick.other)
                            _languagePick = Constants.appUser.languagePreference;

                          if (_errors.length == 0)
                          {

                            Recipe recipe = Recipe( duration: _preptime, ingredients: _ingredients,
                                                    stepDescriptions: _steps, title: _title,
                                                    description: _description, type: _recipeType,
                                                    language: _languagePick,
                                                    isVegetarian: _dietField != DietField.any,
                                                    isVegan: _dietField == DietField.vegan,
                                                    userMap: Constants.appUser.toCompactMap());

                            RecipeService recipeService = RecipeServiceFirestore();
                            String recipeID = await recipeService.addRecipe( recipe );

                            List<File> recipeImages = List<File>();
                            recipeImages.add(_banner);
                            recipeImages.addAll( _images );
                            imageHandler.uploadAndSetRecipeImages(recipeImages, recipeID);

                            Navigator.pop(context);
                            showDialog(
                              context: context, 
                              child: InfoPopup(
                                Localization.instance.language.getMessage( 'created_recipe' ), 
                                Localization.instance.language.getMessage( 'thank_you_recipe' ),
                              ),
                            );
                          }
                          else
                          {
                            setState(() {});
                          }

                        },
                      ),
                    ),

                    Padding(
                     padding: EdgeInsets.only(
                     bottom: MediaQuery.of(context).viewInsets.bottom)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStepDisplay(int index)
  {

    if (stepKeys.length <= index)
      stepKeys.add( GlobalKey() );

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
                      onChanged: (content) {
                        _steps[index] = content;
                      },
                      hint: _steps.length > index ? _steps[index] : Localization.instance.language.getMessage( 'step_info_hint' ),
                      key: stepKeys[index],
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
                  
                  buildStepImagePicker(index),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ActionButton(
                        index == _steps.length ? 
                          Localization.instance.language.getMessage( 'add_step' ) : 
                          Localization.instance.language.getMessage( 'update_step' ),
                        onClick: () {
                          setState(() {
                            if (index >= _steps.length) {
                              _steps.add( stepKeys[index].currentState.getCurrentText() );
                              _images.add( null );
                            } 
                            else
                            {
                              _steps[ index ] = stepKeys[index].currentState.getCurrentText();
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

  Widget buildStepImagePicker(int index)
  {
    return ChooseImageIcon(
      heigth: 100.0,
      width: 100.0,
      image: index < _images.length ? _images[index] : null,
      size: 25.0,
      callback: (tapLocation) async {
        
        // double left;
        // double top;
        // if (tapLocation != null)
        // {
        //   left = tapLocation.dx;
        //   top = tapLocation.dy;
        // }
        // else
        // {
        //   left = MediaQuery.of(context).size.width / 3;
        //   top = MediaQuery.of(context).size.height / 3;
        // }

        File selected = await imageHandler.getPicture();
        setState(() {
          if (selected != null)
            if (index >= _steps.length) {
              _images.add( selected );
            } 
            else
            {
              _images[ index ] = selected;
            }
        });

        // showMenu(
        //   context: context,
        //   position: RelativeRect.fromLTRB(left, top, MediaQuery.of(context).size.width - left, MediaQuery.of(context).size.height - top),
        //   items: <PopupMenuEntry>[
        //     PopupMenuItem(
        //       enabled: false,
        //       child: ListTile(
        //         title: Text( Localization.instance.language.getMessage( 'camera' ) ),
        //         onTap: () async {
        //           File selected = await imageHandler.getPicture(  );
        //           setState(() {
        //             if (selected != null)
        //               if (index >= _steps.length) {
        //                 _images.add( selected );
        //               } 
        //               else
        //               {
        //                 _images[ index ] = selected;
        //               }
        //           });
        //         },
        //       ),
        //     ),
        //     PopupMenuItem(
        //       enabled: false,
        //       child: ListTile(
        //         title: Text( Localization.instance.language.getMessage( 'gallery' ) ),
        //         onTap: () async {
        //           File selected = await imageHandler.getPicture(  );
        //           setState(() {
        //             if (selected != null)
        //               if (index >= _steps.length) {
        //                 _images.add( selected );
        //               } 
        //               else
        //               {
        //                 _images[ index ] = selected;
        //               }
        //           });
        //         },
        //       ),
        //     ),
        //   ]
        // );
      },
    );
  }
}