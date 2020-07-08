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

  _SearchScreen()
  {
    _ingredients.add("Aardappels");
    _ingredients.add("Wortels");
    _ingredients.add("Steak");
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

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          // Searchbox
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: <Widget>[

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

                    GridView.count(
                      shrinkWrap: true,
                      childAspectRatio: 4.0 / 1.0,
                      crossAxisCount: 2,
                      children: <Widget>[
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Diet of choice")
                          ),
                        ),

                        DropdownButton<DietField>(
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
                              child: Text(value.getString()),
                            );
                          }).toList(),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Type of dish")
                          ),
                        ),

                        DropdownButton<RecipeType>(
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
                              child: Text(value.getString()),
                            );
                          }).toList(),
                        ),

                      ],
                    ),
                    
                    SizedBox(
                      height: 30.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        children: <Widget>[
                          Text("Add required ingredients below:"),
                          TextFormField(
                            enableSuggestions: true,
                            controller: _controller,
                            maxLines: 1,
                            onFieldSubmitted: (String text) {
                              setState(() {
                                if (text != "") {
                                  _ingredients.add( text );
                                  _controller.clear();
                                }
                              });
                            },
                            decoration: InputDecoration(
                              focusColor: Constants.main,
                              hintText: "Add required ingredients here",
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30.0,
                    ),

                    ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        // Display selected recipes
                        for (int i = 0; i < _ingredients.length; i++)
                          buildIngredientDisplay(i)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  //   child: RaisedButton(
                  //     child: Text("Search"),
                  //     onPressed: () {
                  //       // TODO: implement search
                  //     }
                  //   ),
                  // ),