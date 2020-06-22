import 'package:flutter/material.dart';
import 'package:yummytummy/popup/recipe_page.dart';
import 'package:yummytummy/user_interface/components/recipe_card.dart';
import 'package:yummytummy/utils/storeData.dart';

import '../constants.dart';

class AddRecipeButton extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () => showDialog(context: context, child: RecipePage(getRecipes()[0])),
        child: Icon(Icons.add),
        backgroundColor: Constants.main,
      );
  }
}