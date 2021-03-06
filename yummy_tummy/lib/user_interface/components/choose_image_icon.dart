import 'dart:io';

import 'package:flutter/material.dart';

import '../constants.dart';

class ChooseImageIcon extends StatefulWidget {

  final Function(Offset tapPosition) callback;
  final File image;
  final double size;
  final double width;
  final double heigth;

  ChooseImageIcon({this.callback, this.image, this.width, this.heigth, this.size});

  @override
  State<StatefulWidget> createState() {
    return _ChooseImageIconState();
  }

}

class _ChooseImageIconState extends State<ChooseImageIcon> {
  
  Offset _tapPosition;

  void _handleTapDown(TapDownDetails details) {
    _tapPosition = details.globalPosition;
    if ( widget.callback != null )
      widget.callback( _tapPosition );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      child: widget.image == null ?
        buildIconContainer() :
        buildImageContainer()
    );
  }

  Widget buildIconContainer()
  {
    return Container(
      height: widget.heigth ?? 50.0,
      width: widget.width ?? 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Constants.bg_gray,
      ),
      child: Icon(
        Icons.image,
        color: Constants.main,
        size: widget.size,
      )
    );
  }

  Widget buildImageContainer()
  {
    return Container(
      height: widget.heigth ?? 50.0,
      width: widget.width ?? 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Constants.bg_gray,
        image: DecorationImage(
          image: FileImage( widget.image ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(),
    );
  }
}