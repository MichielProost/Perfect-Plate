import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/action_button.dart';
import 'package:yummytummy/user_interface/components/custom_textfield.dart';
import 'package:yummytummy/user_interface/components/recipe_card.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/widgets/better_expansion_tile.dart';

class SearchByName extends StatefulWidget {
  
  final RecipeService recipeService = RecipeServiceFirestore();

  @override
  State<StatefulWidget> createState() {
    return _SearchByNameState();
  }

}

class _SearchByNameState extends State<SearchByName> {
  
  List<Widget> _foundRecipes;
  String _searchedAuthor;

  final GlobalKey<BetterExpansionTileState> _expansionTileKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 50.0),
      child: Card(
        child: Column(
          children: <Widget>[
            
            // Action row with close button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CloseButton(),
              ],
            ),
            
            // Search expandable list tile
            buildSearchTile(),

            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: _foundRecipes != null ?
                  _foundRecipes :
                  <Widget>[
                    Text(
                      "Use the form above to search for recipes from a specific author",
                      textAlign: TextAlign.center,
                      style: Constants.emptyScreenStyle,
                    ),
                  ],
              ),
            ),

          ],
        ),
      ),
    );
  }


  void handleSearch() async
  {
    _foundRecipes = List<Widget>();
    List<Recipe> found = await widget.recipeService.getRecipesFromUser(UserMapField.name, _searchedAuthor);
    setState(() {
      for (Recipe recipe in found)
      {
        _foundRecipes.add( RecipeCard( recipe, showBookmark: false, showNumReviews: true,) );
      }

      if (_foundRecipes.length == 0) {
        _foundRecipes.add( Text(
          "This author does not exist or has no recipes\n:-(",
          textAlign: TextAlign.center,
          style: Constants.emptyScreenStyle,
        ));

        _expansionTileKey.currentState.openExpansion();
      }
    });
  }


  Widget buildSearchTile()
  {
    return Theme(
      data: ThemeData(
        accentColor: Constants.main,
      ),
      child: BetterExpansionTile(
        
        // Expandable exterior
        title: Text(
          "Search by name",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: Icon(Icons.search),

        // Expansiontile settings
        initiallyExpanded: true,
        key: _expansionTileKey,

        // Search form inside
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 40.0 ),
            child: Column(
              children: <Widget>[

                // Input hint
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Search for recipes by a specific user",
                    textAlign: TextAlign.left,
                  ),
                ),

                // Text input field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: CustomTextField(
                    hint: "User name here (exact match)",
                    onChanged: (content) => _searchedAuthor = content,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ActionButton(
                    "Search",
                    onClick: () {
                      _expansionTileKey.currentState.closeExpansion();
                      handleSearch();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}