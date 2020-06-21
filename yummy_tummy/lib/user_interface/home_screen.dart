import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/general/appbar_bottom.dart';

import 'package:yummytummy/user_interface/general/appbar_top.dart';
import 'package:yummytummy/user_interface/general/side_menu.dart';

class HomeScreen extends StatelessWidget {

  Widget buildIconLink(IconData icon, String pageName, )
  {
    return Container(

    );
  }

  @override
  Widget build(BuildContext context) {
    return  
    Scaffold(
      appBar: AppBarTop(),
      drawer: SideMenu(),
      body: 
        Column(
          children: <Widget>[
            Image(
              image: AssetImage('images/icon.png'),
            ),
            Row(
              
            ),
          ],
      ),
      //bottomNavigationBar: AppBarBottom(),
    );
  }

}