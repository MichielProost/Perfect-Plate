/// Functions as a template for new screens. Should not actually be used

import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/general/add_recipe_button.dart';

import 'package:yummytummy/user_interface/general/appbar_bottom.dart';
import 'package:yummytummy/user_interface/general/appbar_top.dart';
import 'package:yummytummy/user_interface/general/side_menu.dart';

class ScreenTemplate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop(),
      drawer: SideMenu(),
      bottomNavigationBar: AppBarBottom(),
      floatingActionButton: AddRecipeButton(),
    );
  }

}