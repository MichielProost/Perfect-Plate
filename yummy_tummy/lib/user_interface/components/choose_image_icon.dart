import 'dart:io';

import 'package:flutter/material.dart';

import '../constants.dart';

class ChooseImageIcon extends StatelessWidget {

  final VoidCallback callback;
  final String infoText;
  final double size;
  final double width;
  final double heigth;

  ChooseImageIcon({this.callback, this.infoText, this.width, this.heigth, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigth ?? 50.0,
      width: width ?? 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Constants.bg_gray,
      ),
      child: infoText == null ? 
        buildIconButton() :
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildIconButton(),
            Text(
              infoText,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
      ),
    );
  }

  Widget buildIconButton()
  {
    return IconButton(
      icon: Icon(
        Icons.image,
        color: Constants.main,
        size: size,
      ), 
      onPressed: () {
        if ( callback != null )
          callback();
      }
    );
  }

}