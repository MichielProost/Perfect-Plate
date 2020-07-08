/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/model/recipe.dart';

import 'constants.dart';

class SearchScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }

}

class _SearchScreen extends State<SearchScreen> {
  
  // TODO implement more search fields
  // TODO grab preferences for diet from the user
  DietField _dietField = DietField.none;
  RecipeType _recipeType = RecipeType.mains;
  SortField _sortField = SortField.rating;
  List<String> _ingredients = List<String>();
  
  Widget buildDietPicker(String name, DietField field)
  {
    return RadioListTile<DietField>(
      value: field, 
      groupValue: _dietField, 
      onChanged: (DietField value) => setState(() => _dietField = value),
      title: Text(name),
    );
  }

  Widget buildRecipeTypePicker(String name, RecipeType recipeType)
  {
    return RadioListTile(
      value: recipeType, 
      groupValue: _recipeType, 
      onChanged: (RecipeType value) => setState(() => _recipeType = recipeType),
      title: Text(name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // TODO implement language system
          // Headline
          Center(
            child: Text(
              "Search for recipes",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          // Searchbox
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[

                  // Search criteria

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            // Choose diet: none/vegan/vegetarian
                            Row(
                              children: <Widget>[
                                Text('Pick your diet'),
                              ],
                            ),
                            buildDietPicker('Vegetarian', DietField.vegetarian),
                            buildDietPicker('Vegan',      DietField.vegan),
                            buildDietPicker('Neither',    DietField.none),
                          ],
                        ),
                      ),
                      
                      // Divide both sides
                      Container(
                        color: Colors.black,
                        width: 1.0,
                        height: 130.0,
                      ),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // Choose diet: none/vegan/vegetarian
                            Row(
                              children: <Widget>[
                                Text('Dish type'),
                              ],
                            ),
                            for (RecipeType type in RecipeType.values)
                              buildRecipeTypePicker(type.getString(), type),
                          ],
                        ),
                      ),

                    ],
                  ),

                  
                  // Choose type of dish: RecipeType
                  // Choose ingredients

                  // Search sorting
                  // Select sortfield

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: RaisedButton(
                      child: Text("Search"),
                      onPressed: () {
                        // TODO: implement search
                      }
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}