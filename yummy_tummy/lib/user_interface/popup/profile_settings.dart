import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/components/action_button.dart';
import 'package:yummytummy/user_interface/constants.dart';

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

  void _saveChanges() {
    Constants.appUser.dietFieldPreference = _dietPreference;
    Constants.appUser.recipeTypePreference = _coursePreference;

    widget.userService.modifyUser( Constants.appUser , Constants.appUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 450.0),
      child: Card(
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
              "Personal preferences",
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
                      child: Text("Diet of choice")
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
                        child: Text(value.getString()),
                      );
                    }).toList(),
                  ),

                  // Text label
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Dish preference")
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
                        child: Text(value.getString()),
                      );
                    }).toList(),
                  ),

                ],
              ),
            ),

            Spacer(),

            ActionButton(
              'Okay',
              onClick: () { _saveChanges(); Navigator.pop(context); },
            ),

            Spacer(),

          ],
        ),
      ),
    );
  }

}