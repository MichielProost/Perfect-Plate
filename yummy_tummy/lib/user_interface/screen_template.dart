/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';

import 'general/add_recipe_button.dart';
import 'general/appbar_bottom.dart';
import 'general/appbar_top.dart';
import 'general/side_menu.dart';
import 'screen_handler.dart';

class ScreenTemplate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop(),
      drawer: SideMenu(),
      bottomNavigationBar: AppBarBottom(AppPage.none),
      floatingActionButton: AddRecipeButton(),
    );
  }

}