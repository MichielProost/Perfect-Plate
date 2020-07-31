/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/query/queryInfo.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/components/waiting_indicator.dart';
import 'package:yummytummy/user_interface/popup/snackbar_util.dart';

import 'components/recipe_card.dart';
import 'constants.dart';
import 'localisation/localization.dart';

class FeedScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _FeedScreenState();
  }

}

class _FeedScreenState extends State<FeedScreen> {

  final RecipeService _recipeService = RecipeServiceFirestore();
  ScrollController controller;
  RecipeQuery query = RecipeQuery();

  int lastTimeLoaded = DateTime.now().millisecondsSinceEpoch;

  void fetchNextRecipes() async
  {
    // query = await _recipeService.searchRecipes(query, SortField.weightedRating, Constants.appUser.dietFieldPreference, Constants.appUser.recipeTypePreference, List<String>());
    query = await _recipeService.searchRecipes(query, SortField.weightedRating, Constants.appUser.dietFieldPreference, RecipeType.any, List<String>());
    setState(() {});
  }

  @override
  void initState()
  {
    super.initState();
    fetchNextRecipes();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose()
  {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() async
  {
    // If end nearly reached
    double position = controller.position.extentAfter;
    double currentPos = controller.position.extentBefore;
    if (position < 500)
    {
      // Check load cooldown
      int now = DateTime.now().millisecondsSinceEpoch;
      if (now - lastTimeLoaded < 500)
        return;
      
      lastTimeLoaded = now;

      // Update query
      if (query.hasMore)
      {
        // query = await _recipeService.searchRecipes(query, SortField.weightedRating, Constants.appUser.dietFieldPreference, Constants.appUser.recipeTypePreference, List<String>());
        query = await _recipeService.searchRecipes(query, SortField.weightedRating, Constants.appUser.dietFieldPreference, RecipeType.any, List<String>());
        controller = new ScrollController( initialScrollOffset: currentPos )..addListener( _scrollListener );
        setState(() {});
      }
    }
  }

  Future<RecipeQuery> _getQuery() async {
    return query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      body: FutureBuilder<RecipeQuery> (
        future: _getQuery(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) 
          {
            return snapshot.hasError ?
              SnackBarUtil.createTextSnackBar( Localization.instance.language.getMessage( 'recipe_database_error' ) ) :
              Theme(
                data: Constants.themeData,
                child: ListView(
                  controller: controller,
                  children: <Widget>[
                    
                    if (snapshot.data == null || snapshot.data.recipes.length == 0)
                      Padding(
                        padding: const EdgeInsets.only( top: 20.0 ),
                        child: Text(
                          Localization.instance.language.getMessage( 'no_recipes_found' ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      if (snapshot.data != null && snapshot.data.recipes.length != 0)
                        for (Recipe recipe in snapshot.data.recipes) 
                          RecipeCard(recipe, showBookmark: false, showNumReviews: true),

                    SizedBox(
                      height: 30.0,
                    ),  
                ],
            ),
              );
          } 
          else
          {
            return WaitingIndicator();
          }
        },
      ), 
    );
  }
}