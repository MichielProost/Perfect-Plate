import 'package:flutter/material.dart';

import '../constants.dart';
import '../screen_handler.dart';

class AppBarBottom extends StatefulWidget {
  
  final AppBarBottomState appBarBottomState;

  AppBarBottom(AppPage currentPage):
    appBarBottomState = AppBarBottomState( currentPage );

  @override
  State<StatefulWidget> createState() {
    return appBarBottomState;
  }
}

class AppBarBottomState extends State<AppBarBottom> {
  
  AppPage _currentPage;

  AppBarBottomState(this._currentPage);

  void refresh (AppPage newPage)
  {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Constants.main,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text("Placeholder, broooo!  " + _currentPage.toString()),
          ],
        ),
      ),
    );
  }
}