import 'package:flutter/material.dart';

import '../constants.dart';

enum ActivePage {
  home,
  top,
  favorites,
  profile,
  search,
  none
}

class AppBarTop extends StatelessWidget implements PreferredSizeWidget {

  final AppBar _appbar = AppBar(
    title: Text("Perfect Plate"),
    backgroundColor: Constants.main,
  );

  @override
  Widget build(BuildContext context) {
    return _appbar;
  }

  @override
  Size get preferredSize => new Size.fromHeight(_appbar.preferredSize.height);
}