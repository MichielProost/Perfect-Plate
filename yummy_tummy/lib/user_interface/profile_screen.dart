import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yummytummy/database/buffer/User_content_buffer.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/board/medal_board.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/storage/storageHandler.dart';
import 'package:yummytummy/user_interface/components/buttons/google_signin_button_wrapper.dart';
import 'package:yummytummy/user_interface/components/medal_widget.dart';
import 'package:yummytummy/user_interface/components/recipe_card.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
import 'package:yummytummy/user_interface/popup/create_recipe_card.dart';

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

  final UserContentBuffer _contentBuffer = UserContentBuffer.instance;
  Map<UserPage, List<Widget>> _pageWidgetMap = Map<UserPage, List<Widget>>();

  FileImage profileImage;

  _Screen()
  {

    FirebaseAnalytics().logEvent(name: 'open_screen', parameters: {'Screen': 'Profile'} );

    _pageWidgetMap = {
      UserPage.recipes : List<Widget>(),
      UserPage.reviews : List<Widget>(),
      UserPage.medals  : List<Widget>(),
    };
  }


  // Initialize starting page
  UserPage _activePage = UserPage.medals;

  Widget buildContentLink(UserPage userPage)
  {
    return InkWell(
      onTap: () {
        FirebaseAnalytics().logEvent(name: 'user_page_subpage', parameters: {'Page': userPage.getString()} );
        setState(() {
          _activePage = userPage;
        });
      },
      child: Column(
        children: <Widget>[
          Text(
            Localization.instance.language.profilePageName( userPage ),
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTapDown: (details) {

                StorageHandler imageHandler = StorageHandler();

                Offset tapLocation = details.globalPosition;
                
                double left;
                double top;
                if (tapLocation != null)
                {
                  left = tapLocation.dx;
                  top = tapLocation.dy;
                }
                else
                {
                  left = MediaQuery.of(context).size.width / 3;
                  top = MediaQuery.of(context).size.height / 3;
                }
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(left, top, MediaQuery.of(context).size.width - left, MediaQuery.of(context).size.height - top),
                  items: <PopupMenuEntry>[
                    PopupMenuItem(
                      value: ImageInput.camera,
                      child: InkWell(
                        child: Text( Localization.instance.language.getMessage( 'camera' ) ),
                        onTap: () async {
                          File selected = await imageHandler.getPicture( ImageSource.camera );
                          if (selected != null) {
                            profileImage = FileImage( selected );
                            await imageHandler.uploadAndSetProfileImage( selected );
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    PopupMenuItem(
                      value: ImageInput.gallery,
                      child: InkWell(
                        child: Text( Localization.instance.language.getMessage( 'gallery' ) ),
                        onTap: () async {
                          File selected = await imageHandler.getPicture( ImageSource.gallery );
                          if (selected != null) {
                            profileImage = FileImage( selected );
                            await imageHandler.uploadAndSetProfileImage( selected );
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    if (Constants.appUser.image != null && Constants.appUser.image != '')
                      PopupMenuItem(
                        value: ImageInput.gallery,
                        child: InkWell(
                          child: Text( Localization.instance.language.getMessage( 'delete' ) ),
                          onTap: () async {
                            UserService userService = UserServiceFirestore();
                            await userService.deleteProfilePicture( Constants.appUser );
                            setState(() {
                              profileImage = null;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                  ]
                );
              },
              child: 
              (Constants.appUser.image == null || Constants.appUser.image == '') && profileImage == null ?
              CircleAvatar(
                backgroundColor: Constants.main,
                radius: 60.0,
                child: Image(
                  image: AssetImage('images/user_pic.png'),
                ),
              ) :
              CircleAvatar(
                backgroundColor: Constants.main,
                backgroundImage: NetworkImage( Constants.appUser.image ) ?? profileImage,
                radius: 60.0,
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

          /// User rank display
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              Localization.instance.language.rankName( Constants.appUser.rank ),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),

          if (Constants.appUser.hasNextRank())
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 120.0),
              child: LinearProgressIndicator(
                backgroundColor: Constants.bg_gray,
                value: Constants.appUser.score / Constants.appUser.rank.getNextRank().getRequiredScore(),
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
                buildContentLink(UserPage.medals),
                buildContentLink(UserPage.recipes),
                buildContentLink(UserPage.reviews),
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
      // Get all recipes and reset widget list
      List<Recipe> recipes = await _contentBuffer.getUserRecipes( Constants.appUser );
      _pageWidgetMap[ _activePage ] = List<Widget>();

      // Add a RecipeCard for each recipe
      for (Recipe recipe in recipes)
        _pageWidgetMap[ _activePage ].add( RecipeCard( recipe, canBeDeleted: true, ) );

    }
    else if ( _activePage == UserPage.reviews )
    {
      // Get all reviews and reset widget list
      List<Review> reviews = await _contentBuffer.getUserReviews( Constants.appUser );
      _pageWidgetMap[ _activePage ] = List<Widget>();

      // Add a ReviewCard for each review
      for (Review review in reviews)
        _pageWidgetMap[ _activePage ].add( ReviewCard( review, allowRecipeLink: true, ) );

    }
    else if ( _activePage == UserPage.medals )
    {
      // Reset widget list
      _pageWidgetMap[ _activePage ] = List<Widget>();
      
      // Update medals
      if ( !Constants.appUser.board.seriesMap['create_recipes'].isFinished() ){
        Constants.appUser.board.seriesMap['create_recipes']
            .checkCurrentMedalAchieved(await _contentBuffer.getUserRecipes(Constants.appUser));
      }
      if ( !Constants.appUser.board.seriesMap['write_reviews'].isFinished() ){
        Constants.appUser.board.seriesMap['write_reviews']
            .checkCurrentMedalAchieved(await _contentBuffer.getUserReviews(Constants.appUser));
      }
      if ( !Constants.appUser.board.seriesMap['receive_reviews'].isFinished() ){
        Constants.appUser.board.seriesMap['receive_reviews']
            .checkCurrentMedalAchieved(await _contentBuffer.getUserRecipes(Constants.appUser));
      }
      if ( !Constants.appUser.board.seriesMap['login'].isFinished() ){
        Constants.appUser.board.seriesMap['login']
            .checkCurrentMedalAchieved([]);
      }
      if ( !Constants.appUser.board.seriesMap['add_favourite'].isFinished() ){
        Constants.appUser.board.seriesMap['add_favourite']
            .checkCurrentMedalAchieved(Constants.appUser.favourites);
      }

      // Get all medals and convert them to MedalWidgets
      MedalBoard board = Constants.appUser.board;
      List<Widget> series = List<Widget>();
      board.seriesMap.forEach((key, value) {
        series.add( MedalWidget.series(value) );
      });

      // Add the widgets to the listview as rows (per two)
      for (int i = 0; i < series.length; i++)
      {
        Widget left = series[i];
        Widget right;

        i++;

        if (series.length > i)
          right = series[i];

        _pageWidgetMap[ _activePage ].add(
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 15.0 ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                left,
                if (right != null)
                  right,
              ],
            ),
          )
        );
      }
    }

    return _pageWidgetMap[ _activePage ];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: Constants.fontFamily,
      ),
      child: Scaffold(
        backgroundColor: Constants.background,
        body: Theme(
          data: Constants.themeData,
          child: 
          ! Constants.appUser.isLoggedIn() ?  
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                Localization.instance.language.getMessage( 'profile_login_error' ),
                textAlign: TextAlign.center,
                style: Constants.emptyScreenStyle,
              ),
              Center(child: GoogleSigninButtonWrapper(
                onPressed: () {
                  setState(() {});
                },
              )),
            ],
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
              SliverToBoxAdapter(
                child: FutureBuilder<List<Widget>>(
                  future: _getDisplayedWidgets(),
                  builder: (context, snapshot)
                  {
                    if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null)
                      return Container();

                    if (snapshot.data == null)
                      return Padding(
                        padding: const EdgeInsets.only( top: 20.0 ),
                        child: WaitingIndicator(),
                      );
                    else if (snapshot.data.length != 0)
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return snapshot.data[index];
                        },
                      );
                    else
                      return Center(
                        child: Text(
                          Localization.instance.language.emptyProfilePageError( _activePage ),
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
      ),
    );
  }

}