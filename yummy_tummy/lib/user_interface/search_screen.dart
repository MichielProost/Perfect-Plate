/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/dummy/dummydatabase.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/components/recipe_card.dart';
import 'package:yummytummy/user_interface/widgets/better_expansion_tile.dart';

import 'constants.dart';

class SearchScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }

}

class _SearchScreen extends State<SearchScreen> {
  
  RecipeService _recipeService = DummyDatabase(delayInMilliseconds: 500);

  // TODO grab preferences for diet from the user
  DietField _dietField = DietField.none;
  RecipeType _recipeType = RecipeType.mains;
  SortField _sortField = SortField.rating;
  List<String> _ingredients = List<String>();
  
  bool _hasSearched = false;
  List<Recipe> _foundRecipes = List<Recipe>();

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
  final GlobalKey<BetterExpansionTileState> _expansionTile = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Searchbox
          Card(
            child: Theme(
              data: ThemeData(
                accentColor: Constants.main,
              ),
              child: BetterExpansionTile(
                key: _expansionTile,
                title: Center(
                    child: Text(
                      "Search for recipes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                initiallyExpanded: true,
                leading: Icon(Icons.search),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[

                        GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: 4.0 / 1.0,
                          crossAxisCount: 2,
                          children: <Widget>[
                            
                            // Text label
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Diet of choice")
                              ),
                            ),

                            // Diet chooser: vegetarian, vegan, ...
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

                            // Text label
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Type of dish")
                              ),
                            ),

                            // Recipe type: main, salad, dessert, ...
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
                          height: 20.0,
                        ),

                        // Ingredient input
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
                          height: 20.0,
                        ),

                        // Ingredient dispay
                        Container(
                          height: (_ingredients.length * 60 > 230 ? 230 : _ingredients.length * 60).toDouble(),
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              // Display selected recipes
                              for (int i = 0; i < _ingredients.length; i++)
                                buildIngredientDisplay(i)
                            ],
                          ),
                        ),

                        // Search button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: ButtonTheme(
                            minWidth: 250.0,
                            child: RaisedButton(
                              color: Constants.main,
                              child: Text(
                                "Show recipes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0
                                ),
                              ),
                              onPressed: () {
                                handleSearch();
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: buildSearchResult(),
            ),
          ),

        ],
      ),
    );
  }

  List<Widget> buildSearchResult()
  {
    List<Widget> found = List<Widget>();
    if (! _hasSearched)
      return found;

    if (_foundRecipes.length == 0)
    {
      found.add(
        SizedBox(
          height: 30.0,
        )
      );
      found.add(
        Center(
          child: Text(
            "No recipes were found! Please adjust your search parameters.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
        ),
      );
      found.add(
        SizedBox(
          height: 30.0,
        )
      );
      found.add(
        Center(
          child: Text(
            ":-(",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
            ),
          ),
        ),
      );
    }

    for (Recipe recipe in _foundRecipes)
    {
      found.add( RecipeCard(recipe) );
    }

    found.add(
      SizedBox(
        height: 30.0,
      )
    );

    return found;
  }

  void handleSearch() async {
    List<Recipe> recipes = await _recipeService.searchRecipes(_dietField, SortField.rating);
    setState(() {
      _hasSearched = true;
      _foundRecipes = recipes;
      //_foundRecipes = List<Recipe>();
      _expansionTile.currentState.closeExpansion();
    });
  }
}