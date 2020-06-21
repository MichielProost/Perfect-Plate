import 'package:flutter/material.dart';

import '../constants.dart';
import '../screen_handler.dart';

class AppBarBottom extends StatefulWidget {
  
  final AppPage _currentPage;
  AppBarBottomState appBarBottomState;

  AppBarBottom(this._currentPage) {
    appBarBottomState = AppBarBottomState(_currentPage);
  }

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
    if (this.mounted)
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
            Text("Placeholder, broooo!" + _currentPage.toString()),
          ],
        ),
      ),
    );
  }
}