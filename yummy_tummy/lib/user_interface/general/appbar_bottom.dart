import 'package:flutter/material.dart';

import '../constants.dart';

class AppBarBottom extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Constants.main,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text("Placeholder, broooo!"),
          ],
        ),
      ),
    );
  }
}