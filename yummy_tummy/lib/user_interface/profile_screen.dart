/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/dummy/dummydatabase.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/interfaces/reviewService.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/rating_row.dart';
import 'package:yummytummy/user_interface/components/recipe_card.dart';
import 'package:yummytummy/user_interface/components/review_card.dart';
import 'package:yummytummy/user_interface/popup/recipe_page.dart';

import 'constants.dart';

class ProfileScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _Screen();
  }

}

class _Screen extends State<ProfileScreen> {

  List<Widget> _recipes = List<Widget>();
  List<Widget> _reviews = List<Widget>(); 
  
  RecipeService _recipeService = DummyDatabase(delayInMilliseconds: 500);
  ReviewService _reviewService = DummyDatabase(delayInMilliseconds: 100);

  _Screen()
  {
    // TODO Get actual data and remove code below + make this page Future proof
    for (Recipe recipe in DummyDatabase().getRecipes() )
    {
      _recipes.add( RecipeCard(recipe) );
    }

    for (Review review in DummyDatabase().getReviews())
    {
      _reviews.add( 
        InkWell(
          onTap: () {
            _openRecipeID( review.recipeID );
          },
          child: ReviewCard( review )
        ),
      );
    }

    // Start by displaying recipes
    displayed = _recipes;
  }

  void _openRecipeID( String recipeID ) async
  {
    Recipe recipe = await _recipeService.getRecipeFromID( recipeID );
    showDialog(context: context, child: RecipePage( recipe ));
  }

  // TODO add logic for when not logged in
  // TODO get actual logged in User object
  User _user = DummyDatabase().getUsers()[1];  
  List<Widget> displayed = List<Widget>();

  Widget buildContentLink(String name, List<Widget> content)
  {
    return InkWell(
      onTap: () {
        setState(() {
          displayed = content;
        });
      },
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: 20.0,
              color: displayed == content ? Constants.main : Constants.text_gray,
              fontWeight: displayed == content ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader()
  {
    return Column(
      children: <Widget>[
        /// Profile picture
          // TODO implement profile picture
          // TODO implement profile picture changing
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircleAvatar(
              backgroundColor: Constants.main,
              radius: 60.0,
              child: Image(
                image: AssetImage('images/user_pic.png'),
              ),
            ),
          ),

          /// User name display
          Text(
            _user.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),

          /// Seperator line
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 2.0,
              color: Colors.grey.shade400,
            ),
          ),
      ],
    );
  }

  Widget buildNavigator()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
            /// content selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildContentLink("My recipes", _recipes),
                buildContentLink("My reviews", _reviews),
              ],
            ),

            /// Separator space
            SizedBox(
              height: 15.0,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      body: Theme(
        data: Constants.themeData,
        child: CustomScrollView(
          slivers: <Widget>[

            // Header
            SliverToBoxAdapter(
              child: buildHeader(),
            ),

            // Navigation bar
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              title: buildNavigator(),
              backgroundColor: Constants.background,
            ),

            // Recipes or review depending on the selected page
            for (Widget widget in displayed)
              SliverToBoxAdapter(
                child: widget,
              ),

            // Extra padding to prevent overlap with the add recipe button
            SliverPadding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
          ],
        ),
      ),
    );
  }

}