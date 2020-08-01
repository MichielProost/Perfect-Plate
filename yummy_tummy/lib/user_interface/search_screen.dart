/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/query/queryInfo.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/components/recipe_card.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
import 'package:yummytummy/user_interface/widgets/better_expansion_tile.dart';

import 'constants.dart';

class SearchScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }

}

class _SearchScreen extends State<SearchScreen> {
  
  // Database util
  RecipeService _recipeService = RecipeServiceFirestore();
  RecipeQuery info = new RecipeQuery();

  ScrollController _scrollController;


  // User set parameters
  DietField _dietField = Constants.appUser.dietFieldPreference;
  RecipeType _recipeType = Constants.appUser.recipeTypePreference;
  LanguagePick _languagePreference = Constants.appUser.languagePreference;
  SortField _sortField = SortField.weightedRating;
  final List<String> _ingredients = List<String>();
  
  // State information
  bool _hasSearched = false;
  int lastTimeLoaded = DateTime.now().millisecondsSinceEpoch;
  List<Recipe> _foundRecipes = List<Recipe>();

  @override
  void initState()
  {
    super.initState();
    _scrollController = new ScrollController()..addListener( _scrollHandler );
  }

  @override
  void dispose()
  {
    _scrollController.dispose();
    super.dispose();
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
  final GlobalKey<BetterExpansionTileState> _expansionTile = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Constants.background,
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
                      Localization.instance.language.getMessage( 'search_recipes_title' ),
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
                                child: Text( Localization.instance.language.getMessage( 'select_diet' ) )
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
                                  child: Text( Localization.instance.language.dietFieldName( value ) ),
                                );
                              }).toList(),
                            ),

                            // Text label
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text( Localization.instance.language.getMessage( 'select_course' ) )
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
                                  child: Text( Localization.instance.language.recipeTypeName(value) ),
                                );
                              }).toList(),
                            ),


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
                                    child: Text(value != LanguagePick.other ? Localization.instance.language.languageName( value ) : Localization.instance.language.languageName( Constants.appUser.languagePreference )),
                                  );
                                }
                              ).toList(),
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
                              Text( Localization.instance.language.getMessage( 'ingredients_selector' ) ),
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
                                  hintText: Localization.instance.language.getMessage( 'ingredients_hint' ),
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
                                Localization.instance.language.getMessage( 'show_recipes' ),
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
              controller: _scrollController,
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
            style: Constants.emptyScreenStyle,
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
    info = new RecipeQuery();
    RecipeQuery result = await _recipeService.searchRecipes(info, _sortField, _dietField, _recipeType, _ingredients, language: _languagePreference);
    setState(() {
      _hasSearched = true;
      _foundRecipes = result.recipes;
      //_foundRecipes = List<Recipe>();
      _expansionTile.currentState.closeExpansion();
    });
  }

  void _scrollHandler() async
  {
    // If end nearly reached
    double position = _scrollController.position.extentAfter;
    double currentPos = _scrollController.position.extentBefore;
    if (position < 500)
    {
      // Check load cooldown
      int now = DateTime.now().millisecondsSinceEpoch;
      if (now - lastTimeLoaded < 500)
        return;
      
      lastTimeLoaded = now;

      // Update query
      if (info.hasMore)
      {
        info = await _recipeService.searchRecipes(info, SortField.weightedRating, DietField.any, RecipeType.any, List<String>());
        _scrollController = new ScrollController( initialScrollOffset: currentPos )..addListener( _scrollHandler );
        setState(() {
          _foundRecipes = info.recipes;
          if (_foundRecipes.length > 0)
          {
            _hasSearched = true;
          }
        });
      }
    }
  }
}