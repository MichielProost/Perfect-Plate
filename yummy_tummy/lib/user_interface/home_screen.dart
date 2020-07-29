import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/screen_handler.dart';

import 'constants.dart';
import 'general/appbar_top.dart';
import 'general/side_menu.dart';

class HomeScreen extends StatelessWidget {

  Widget buildIconLink(IconData icon, AppPage page, String text, BuildContext context)
  {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenHandler( page ))),
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
              text,
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
    return  
    Scaffold(
      appBar: AppBarTop(),
      drawer: SideMenu(),
      backgroundColor: Constants.background,
      body: 
        Column(
          children: <Widget>[
            Image(
              image: AssetImage('images/icon.png'),
              height: 170.0,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildIconLink(Icons.home, AppPage.feed, "Feed", context),
                buildIconLink(Icons.search, AppPage.search, "Search", context),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildIconLink(Icons.bookmark, AppPage.favourites, "Saved", context),
                buildIconLink(Icons.person, AppPage.profile, "Profile", context),
              ],
            ),
            Spacer(),
            // buildIconLink(Icons.home, AppPage.feed, "Feed", context),
            // Spacer(),
          ],
      ),
      //bottomNavigationBar: AppBarBottom(),
    );
  }

}