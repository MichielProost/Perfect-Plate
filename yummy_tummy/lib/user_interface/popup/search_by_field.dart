import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/components/action_button.dart';
import 'package:yummytummy/user_interface/components/custom_textfield.dart';
import 'package:yummytummy/user_interface/components/recipe_card.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
import 'package:yummytummy/user_interface/widgets/better_expansion_tile.dart';

class SearchByField extends StatefulWidget {

  final String explanationMessage;
  final String textBoxHint;
  final String noRecipesFoundMessage;

  final Future<List<Recipe>> Function(String parameter) searchFunction;

  SearchByField(this.explanationMessage, this.textBoxHint, this.noRecipesFoundMessage, this.searchFunction) {
    FirebaseAnalytics().logEvent(name: 'side_menu_submenu', parameters: {'Option': 'search_by_user_or_recipe_name'} );
  }


  @override
  State<StatefulWidget> createState() {
    return _SearchByFieldState();
  }

}

class _SearchByFieldState extends State<SearchByField> {
  
  List<Widget> _foundRecipes;
  String _searched;

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
                      '',
                      // '\nUse the form above to search for recipes from a specific author\n \nNote that this name is case sensitive!',
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
    if (_searched == null || _searched == '')
      return;

    _foundRecipes = List<Widget>();
    List<Recipe> found = await widget.searchFunction(_searched);
    setState(() {
      for (Recipe recipe in found)
      {
        _foundRecipes.add( RecipeCard( recipe, showBookmark: false, showNumReviews: true,) );
      }

      if (_foundRecipes.length == 0) {
        _foundRecipes.add( Text(
          widget.noRecipesFoundMessage,
          textAlign: TextAlign.center,
          style: Constants.emptyScreenStyle,
        ));

        _expansionTileKey.currentState.openExpansion();
      } else{
        _expansionTileKey.currentState.closeExpansion();
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
          Localization.instance.language.getMessage( 'search_recipes_title' ),
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
                    widget.explanationMessage,
                    textAlign: TextAlign.left,
                  ),
                ),

                // Text input field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: CustomTextField(
                    hint: widget.textBoxHint,
                    onChanged: (content) => _searched = content,
                    callback: (content) {
                      _searched = content;
                      handleSearch();
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ActionButton(
                    Localization.instance.language.getMessage( 'show_recipes' ),
                    onClick: () {
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