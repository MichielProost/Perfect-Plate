import 'package:flutter/material.dart';

import 'package:yummytummy/user_interface/general/appbar_bottom.dart';
import 'package:yummytummy/user_interface/general/appbar_top.dart';
import 'package:yummytummy/user_interface/general/side_menu.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop(),
      drawer: SideMenu(),
      bottomNavigationBar: AppBarBottom(),
    );
  }

}