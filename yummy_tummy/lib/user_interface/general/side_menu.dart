import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/buttons/google_signin_button_wrapper.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
import 'package:yummytummy/user_interface/popup/profile_settings.dart';
import 'package:yummytummy/user_interface/popup/rank_information.dart';
import 'package:yummytummy/user_interface/popup/search_by_field.dart';

class SideMenu extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    FirebaseAnalytics().logEvent(name: 'open_screen', parameters: {'Screen': 'Side menu'} );
    return _Menu();
  }
}

class _Menu extends State<SideMenu> {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Constants.main,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              
              Center(
                child: Column(
                  children: <Widget>[
                    Image.asset( 
                      "images/icon.png" ,
                      height: 75.0,
                    ),
                    Text(
                      "Perfect Plate",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                      child: Container(
                        height: 1.0,
                        color: Constants.bg_gray,
                      ),
                    ),
                  ],
                ),
              ),

              // Log in button for logged out users
              if (!Constants.appUser.isLoggedIn())
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GoogleSigninButtonWrapper(
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),

              

              // Clickable elements
              _SideListItem(Localization.instance.language.getMessage( 'search_by_user_title' ), Icons.search, SearchByField(
                Localization.instance.language.getMessage( 'search_by_user_title' ),
                Localization.instance.language.getMessage( 'search_by_user_hint' ),
                Localization.instance.language.getMessage( 'author_not_found' ),
                (String message) {
                  return RecipeServiceFirestore().getRecipesFromUser(UserMapField.name, message);
                }
              )),
              _SideListItem(Localization.instance.language.getMessage( 'search_by_recipe_title' ), Icons.search, SearchByField(
                Localization.instance.language.getMessage( 'search_by_recipe_title' ),
                Localization.instance.language.getMessage( 'search_by_title_hint' ),
                Localization.instance.language.getMessage( 'title_not_found' ),
                (String message) {
                  return RecipeServiceFirestore().getRecipesFromTitle(message);
                }
              )),
              _SideListItem(Localization.instance.language.getMessage( 'rank_overview_sidemenu' ), Icons.info, RankInformation(), mustBeLoggedInToView: true,),
              _SideListItem(Localization.instance.language.getMessage( 'user_preferences' ), Icons.settings, ProfileSettings(), mustBeLoggedInToView: true,),

              // Maximise space and logout button for logged in users
              Spacer(),
              if ( Constants.appUser.isLoggedIn())
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GoogleSigninButtonWrapper(
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SideListItem extends StatelessWidget {
  
  final String text;
  final IconData icon;
  final Widget popupAction;
  final bool logInToView;

  _SideListItem(this.text, this.icon, this.popupAction, {bool mustBeLoggedInToView: false}) : logInToView = mustBeLoggedInToView;

  @override
  Widget build(BuildContext context) {
    return !logInToView || Constants.appUser.isLoggedIn() ?
    ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      onTap: () {
        Navigator.pop(context);
        showDialog(context: context, child: popupAction);
      },
    ) : SizedBox();
  }

}