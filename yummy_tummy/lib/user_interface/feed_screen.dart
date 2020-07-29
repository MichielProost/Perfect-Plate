/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/dummy/dummydatabase.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/query/queryInfo.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/waiting_indicator.dart';
import 'package:yummytummy/user_interface/popup/snackbar_util.dart';

import 'components/recipe_card.dart';
import 'constants.dart';

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

  void fetchNextRecipes() async
  {
    query = await _recipeService.searchRecipes(query, SortField.weightedRating, DietField.any, RecipeType.any, List<String>());
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
    if (position==0)
    {
      print('Reaching end!');
      query = await _recipeService.searchRecipes(query, SortField.weightedRating, DietField.any, RecipeType.any, List<String>());
      setState(() {});
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
              //TODO implement language
              SnackBarUtil.createTextSnackBar("An error occured while retrieving the recipes!") :
              Theme(
                data: Constants.themeData,
                child: ListView(
                  controller: controller,
                  children: <Widget>[
                    
                    if (snapshot.data == null || snapshot.data.recipes.length == 0)
                      Padding(
                        padding: const EdgeInsets.only( top: 20.0 ),
                        child: Text(
                          "Woops, no recipes found!\n \n:-(",
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