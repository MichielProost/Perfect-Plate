/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/database/buffer/User_content_buffer.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/recipe_card.dart';
import 'package:yummytummy/user_interface/popup/recipe_page.dart';

import 'components/review_card.dart';
import 'components/waiting_indicator.dart';
import 'constants.dart';

class ProfileScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _Screen();
  }

}

enum UserPage {
  medals,
  recipes,
  reviews
}

extension UserPageUtil on UserPage {
  
  String getString()
  {
    String lowercase = this.toString().toLowerCase().split('.').last;
    return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';
  }

}

class _Screen extends State<ProfileScreen> {

  final UserContentBuffer _contentBuffer = UserContentBuffer();
  Map<UserPage, List<Widget>> _pageWidgetMap = Map<UserPage, List<Widget>>();

  _Screen()
  {
    _pageWidgetMap = {
      UserPage.recipes : List<Widget>(),
      UserPage.reviews : List<Widget>(),
      UserPage.medals  : List<Widget>(),
    };
  }


  // Initialize starting page
  UserPage _activePage = UserPage.medals;

  void _openRecipeID( String recipeID ) async
  {
    Recipe recipe;
    List<Recipe> recipes = await _contentBuffer.getUserRecipes( Constants.appUser );
    for (Recipe element in recipes)
      if (element.id == recipeID)
        recipe = element;
    
    if (recipe != null)
      showDialog(context: context, child: RecipePage( recipe ));
  }

  Widget buildContentLink(String name, UserPage userPage)
  {
    return InkWell(
      onTap: () {
        setState(() {
          _activePage = userPage;
        });
      },
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: 20.0,
              color: _activePage == userPage ? Constants.main : Constants.text_gray,
              fontWeight: _activePage == userPage ? FontWeight.bold : FontWeight.normal,
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
            Constants.appUser.name,
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
                buildContentLink("My medals" , UserPage.medals ),
                buildContentLink("My recipes", UserPage.recipes),
                buildContentLink("My reviews", UserPage.reviews),
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

  Future<List<Widget>> _getDisplayedWidgets() async
  {
    if ( _activePage == UserPage.recipes )
    {
      List<Recipe> recipes = await _contentBuffer.getUserRecipes( Constants.appUser );
      _pageWidgetMap[ _activePage ] = List<Widget>();
      for (Recipe recipe in recipes)
        _pageWidgetMap[ _activePage ].add( RecipeCard( recipe ) );
    }
    else if ( _activePage == UserPage.reviews )
    {
      List<Review> reviews = await _contentBuffer.getUserReviews( Constants.appUser );
      _pageWidgetMap[ _activePage ] = List<Widget>();
      for (Review review in reviews)
        _pageWidgetMap[ _activePage ].add( ReviewCard( review ) );
    }
    else if ( _activePage == UserPage.medals )
    {
      _pageWidgetMap[ _activePage ] = <Widget>[Container()];
      // TODO Michiel: fix List<Medal> of iets gelijkaardig. Ik zal er widgets van maken
    }

    return _pageWidgetMap[ _activePage ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      body: Theme(
        data: Constants.themeData,
        child: 
        ! Constants.appUser.isLoggedIn() ?  
        Center(
          child: Text(
            "Please log in to see your profile page.",
            textAlign: TextAlign.center,
            style: Constants.emptyScreenStyle,
          ),
        ) :
        CustomScrollView(
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
            // for (Widget widget in displayed)
            //   SliverToBoxAdapter(
            //     child: widget,
            //   ),

            // Recipes or review depending on the selected page
            SliverToBoxAdapter(
              child: FutureBuilder<List<Widget>>(
                future: _getDisplayedWidgets(),
                builder: (context, snapshot)
                {
                  if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null)
                    return Container();

                  if (snapshot.data == null)
                    return WaitingIndicator();
                  else if (snapshot.data.length != 0)
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return snapshot.data[index];
                      },
                    );
                  else
                    return Center(
                      child: Text(
                        "You haven't published " + _activePage.getString().toLowerCase() + " yet!",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                }
              ),
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