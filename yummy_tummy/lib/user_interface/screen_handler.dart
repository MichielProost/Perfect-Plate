/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/favourites_screen.dart';
import 'package:yummytummy/user_interface/feed_screen.dart';
import 'package:yummytummy/user_interface/profile_screen.dart';
import 'package:yummytummy/user_interface/search_screen.dart';

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


  final Map<AppPage, Widget> _pages = {
    AppPage.feed:        FeedScreen(),
    AppPage.search:      SearchScreen(),
    AppPage.favourites:  FavouritesScreen(),
    AppPage.profile:     ProfileScreen(), 
  };

  @override
  State<StatefulWidget> createState() {
    return _ScreenHandler();
  }

}

class _ScreenHandler extends State<ScreenHandler> {

  AppPage _currentPage;
  AppBarBottom _appBarBottom;
    
  final _controller = PageController(
    initialPage: 1,
  );

  _ScreenHandler()
  {
    _currentPage = AppPage.values[_controller.initialPage];
    _appBarBottom = AppBarBottom(_currentPage, _controller);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop(),
      drawer: SideMenu(),
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