/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/favourites_screen.dart';
import 'package:yummytummy/user_interface/feed_screen.dart';
import 'package:yummytummy/user_interface/profile_screen.dart';
import 'package:yummytummy/user_interface/search_screen.dart';

import 'constants.dart';
import 'general/add_recipe_button.dart';
import 'general/appbar_bottom.dart';
import 'general/appbar_top.dart';
import 'general/side_menu.dart';


enum AppPage {
  feed,
  search,
  favourites,
  profile,
  none,
}


class ScreenHandler extends StatefulWidget {

  final AppPage startPage;
  final Map<AppPage, Widget> _pages = {
    AppPage.feed:        FeedScreen(),
    AppPage.search:      SearchScreen(),
    AppPage.favourites:  FavouritesScreen(),
    AppPage.profile:     ProfileScreen(), 
  };

  ScreenHandler( this.startPage );

  @override
  State<StatefulWidget> createState() {
    int startPageId = 1;
    int i = 0;
    _pages.forEach((key, value) { 
      if (key == startPage)
        startPageId = i;
      i++;
    });
    return _ScreenHandler( startPageId );
  }

}

class _ScreenHandler extends State<ScreenHandler> {

  AppPage _currentPage;
  AppBarBottom _appBarBottom;
  
  final _controller;

  _ScreenHandler(int startPageId): _controller = PageController(initialPage: startPageId)
  {
    _currentPage = AppPage.values[_controller.initialPage];
    _appBarBottom = AppBarBottom(_currentPage, _controller);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop(),
      drawer: SideMenu(),
      backgroundColor: Constants.gray,
      body: Center(
        child: PageView (
          controller: _controller,
          onPageChanged:(index) => {
            _currentPage = AppPage.values[index],
            _appBarBottom.appBarBottomState.refresh(_currentPage),
          },
          children: <Widget>[
            widget._pages[AppPage.feed],
            widget._pages[AppPage.search],
            widget._pages[AppPage.favourites],
            widget._pages[AppPage.profile],
          ],
        ),
      ),
      floatingActionButton: AddRecipeButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _appBarBottom,
    );
  }

}