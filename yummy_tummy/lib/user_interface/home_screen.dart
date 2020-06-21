import 'package:flutter/material.dart';

import 'general/appbar_top.dart';
import 'general/side_menu.dart';

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