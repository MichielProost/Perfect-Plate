/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/dummy/dummydatabase.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/rating_row.dart';
import 'package:yummytummy/user_interface/components/recipe_card.dart';

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
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                RatingRow(review.rating.toDouble(), 1),
                Text( review.description ),
              ],
            ),
          ),
          color: Constants.gray,
        ), 
      );
    }

    // Start by displaying recipes
    displayed = _recipes;
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
      child: Text(
        name,
        style: TextStyle(
          fontSize: 20.0,
          color: Constants.text_gray,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              color: Constants.gray,
            ),
          ),

          /// content selector
          // TODO add indicator to show active page
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

          /// Content display
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                for (Widget widget in displayed)
                  widget,
              ],
            ),
          ),
        ],
      ),
    );
  }

}