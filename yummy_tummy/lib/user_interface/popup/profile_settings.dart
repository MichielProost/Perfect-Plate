import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/app_user.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/components/action_button.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

class ProfileSettings extends StatefulWidget {
  
  final UserService userService = UserServiceFirestore();

  @override
  State<StatefulWidget> createState() {
    return _ProfileSettingsState();
  }

}

class _ProfileSettingsState extends State<ProfileSettings>{

  DietField _dietPreference = Constants.appUser.dietFieldPreference;
  RecipeType _coursePreference = Constants.appUser.recipeTypePreference;
  LanguagePick _languagePreference = LanguagePick.other;  // Set to other for display purposes. If kept (or set to) other, language changes will be ignored

  void _saveChanges() {

    // Food preferences
    Constants.appUser.dietFieldPreference = _dietPreference;
    Constants.appUser.recipeTypePreference = _coursePreference;

    // Handle language preference
    if ( _languagePreference != LanguagePick.other ) {
      Constants.appUser.languagePreference = _languagePreference;
      Localization.instance.setLanguage( _languagePreference );
    }

    widget.userService.modifyUser( Constants.appUser , Constants.appUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 70.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    
                    // Button row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CloseButton(onPressed: () {_saveChanges(); Navigator.pop(context); }),
                      ],
                    ),

                    // Title
                    Text(
                      Localization.instance.language.getMessage( 'user_preferences' ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),

                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: 4.0 / 1.0,
                        crossAxisCount: 2,
                        children: <Widget>[
                          
                          // Text label
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(Localization.instance.language.getMessage( 'select_language' )),
                            ),
                          ),

                          // Language dropdown
                          DropdownButton<LanguagePick>(
                            value: _languagePreference,
                            icon: Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            onChanged: (LanguagePick newValue) {
                              setState(() {
                                _languagePreference = newValue;
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

                          // Text label
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(Localization.instance.language.getMessage( 'select_diet' )),
                            ),
                          ),

                          // Diet chooser: vegetarian, vegan, ...
                          DropdownButton<DietField>(
                            value: _dietPreference,
                            icon: Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            onChanged: (DietField newValue) {
                              setState(() {
                                _dietPreference = newValue;
                              });
                            },
                            items: DietField.values
                                .map<DropdownMenuItem<DietField>>((DietField value) {
                              return DropdownMenuItem<DietField>(
                                value: value,
                                child: Text(Localization.instance.language.dietFieldName( value )),
                              );
                            }).toList(),
                          ),

                          // Text label
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(Localization.instance.language.getMessage( 'select_course' )),
                            ),
                          ),

                          // Recipe type: main, salad, dessert, ...
                          DropdownButton<RecipeType>(
                            value: _coursePreference,
                            icon: Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            onChanged: (RecipeType newValue) {
                              setState(() {
                                _coursePreference = newValue;
                              });
                            },
                            items: RecipeType.values
                                .map<DropdownMenuItem<RecipeType>>((RecipeType value) {
                              return DropdownMenuItem<RecipeType>(
                                value: value,
                                child: Text( Localization.instance.language.recipeTypeName( value ) ),
                              );
                            }).toList(),
                          ),

                        ],
                      ),
                    ),

                    Spacer(),

                    ActionButton(
                      Localization.instance.language.getMessage( 'submit' ),
                      onClick: () { _saveChanges(); Navigator.pop(context); },
                    ),

                    Spacer(),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 1.0,
              width: 1.0,
            ),
          ),
        ],
      ),
    );
  }

}