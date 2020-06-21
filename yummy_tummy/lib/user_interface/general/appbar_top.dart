import 'package:flutter/material.dart';

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
    title: Text("Yummy tummy"),
  );

  @override
  Widget build(BuildContext context) {
    return _appbar;
  }

  @override
  Size get preferredSize => new Size.fromHeight(_appbar.preferredSize.height);
}