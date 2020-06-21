import 'package:flutter/material.dart';

import '../constants.dart';
import '../screen_handler.dart';

class AppBarBottom extends StatefulWidget {
  
  final AppBarBottomState appBarBottomState;

  AppBarBottom(AppPage currentPage, PageController controller):
    appBarBottomState = AppBarBottomState( currentPage, controller );

  @override
  State<StatefulWidget> createState() {
    return appBarBottomState;
  }
}

class AppBarBottomState extends State<AppBarBottom> {
  
  AppPage _currentPage;
  PageController _controller;

  AppBarBottomState(this._currentPage, this._controller);

  void refresh (AppPage newPage)
  {
    setState(() {
      _currentPage = newPage;
    });
  }


  Widget createNavButton(IconData icon, String text, AppPage page)
  {
    Color elementColor = _currentPage == page ? Constants.accent : Colors.white;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 70.0,
        width: 70.0,
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: elementColor,
              size: 30.0,
            ),
            Text(
              text,
              style: TextStyle(
                color: elementColor,
              ),
            ),
            Container(
              height: 2.0,
              width: 40.0,
              color: _currentPage == page ? Constants.accent : Constants.main,
            ),
          ],
        ),
      ),
    );

    //     ),
    //     onPressed: () {
    //       _controller.jumpToPage(page.index);
    //       refresh(page);
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.main,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            createNavButton(Icons.star, "Feed", AppPage.feed),
            createNavButton(Icons.search, "Search", AppPage.search),
            Expanded(
              child: SizedBox(),
            ),
            createNavButton(Icons.bookmark, "Favourites", AppPage.favourites),
            createNavButton(Icons.person, "Profile", AppPage.profile)
          ],
        ),
      ),
    );
  }
}