import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:yummytummy/database/authentication/google.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
import 'package:yummytummy/user_interface/popup/profile_settings.dart';
import 'package:yummytummy/user_interface/screen_handler.dart';

import 'constants.dart';
import 'general/appbar_top.dart';
import 'general/side_menu.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }

}

class HomeScreenState extends State<HomeScreen> {

  bool _canTouch = true;
  bool hasBeenBuilt = false;

  bool hasAccount = true;
  bool hasGottenPopup = false;

  HomeScreenState()
  {
    signInAndCheckForNewUser();
  }

  void signInAndCheckForNewUser() async {
    hasAccount = await GoogleAuthHandler().handleSignIn(screen: this);      
  }

  void setTouchable(bool canTouch)
  {
    if (hasBeenBuilt)
      setState(() {
        _canTouch = canTouch;
      });
    else _canTouch = canTouch;
  }

  Widget buildIconLink(IconData icon, AppPage page, BuildContext context)
  {
    return InkWell(
      onTap: () {
        FirebaseAnalytics().logEvent(name: 'start_screen', parameters: {'Screen': page.toString()} );
        Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenHandler( page )));
      },
      child: Container(
        height: 150.0,
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Constants.main,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              size: 60.0,
              color: Colors.white,
            ),
            Text(
              Localization.instance.language.appPageName( page ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!hasGottenPopup && !hasAccount && Constants.appUser.isLoggedIn())
      {
        hasGottenPopup = true;
        showDialog(
          context: context,
          child: ProfileSettings(),
        );
      }
    });
    
    hasBeenBuilt = true;
    return  
    AbsorbPointer(
      absorbing: !_canTouch,
      child: Scaffold(
        appBar: AppBarTop(),
        drawer: SideMenu(),
        backgroundColor: Constants.background,
        body: 
          Column(
            children: <Widget>[
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Constants.main,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child:Image(
                    image: AssetImage('images/icon.png'),
                    height: 170.0,
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildIconLink(Icons.home, AppPage.feed, context),
                  buildIconLink(Icons.search, AppPage.search, context),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildIconLink(Icons.bookmark, AppPage.favourites, context),
                  buildIconLink(Icons.person, AppPage.profile, context),
                ],
              ),
              Spacer(
                flex: 4,
              ),
              // buildIconLink(Icons.home, AppPage.feed, "Feed", context),
              // Spacer(),
            ],
        ),
        //bottomNavigationBar: AppBarBottom(),
      ),
    );
  }

}