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


  Widget createNavButton(IconData icon, AppPage page)
  {
    //Color elementColor = _currentPage == page ? Constants.accent : Colors.white;
    Color elementColor = _currentPage == page ? Colors.white : Colors.grey.shade400;
    return Container(
      height: 70.0,
      width: 70.0,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () { 
          _controller.jumpToPage(page.index);
          refresh(page);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: elementColor,
              size: 40.0,
            ),
            // Text(
            //   Localization.instance.language.appPageName( page ),
            //   maxLines: 1,
            //   style: TextStyle(
            //     color: elementColor,
            //     fontWeight: _currentPage == page ? FontWeight.bold : FontWeight.normal,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Constants.main,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          createNavButton(Icons.star, AppPage.feed),
          createNavButton(Icons.search, AppPage.search),
          SizedBox(width: 65.0,),
          createNavButton(Icons.bookmark, AppPage.favourites),
          createNavButton(Icons.person, AppPage.profile)
        ],
      ),
    );
  }
}