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

class ScreenScroller extends StatelessWidget {

  final controller = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop(),
      drawer: SideMenu(),
      bottomNavigationBar: AppBarBottom(),
      floatingActionButton: AddRecipeButton(),
      body: Center(
        child: PageView (
          controller: controller,
          children: <Widget>[
            FeedScreen(),
            SearchScreen(),
            FavouritesScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }

}