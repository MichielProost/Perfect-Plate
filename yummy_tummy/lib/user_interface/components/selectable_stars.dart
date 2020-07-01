import 'package:flutter/material.dart';

import '../constants.dart';

class SelectableStars extends StatefulWidget {
  
  final double _size;
  int rating = 0;

  SelectableStars(this._size);

  @override
  State<StatefulWidget> createState() {
    return _Stars();
  }

}

class _Stars extends State<SelectableStars> {

  /// Build a star Widget based on its index in the row [1, 5] will be filled or not
  Widget buildStar(int index)
  {
    return IconButton(
      icon: Icon(
        index <= widget.rating ? Icons.star : Icons.star_border,
        size: widget._size,
        color: Constants.accent,
      ), 
      onPressed: () => {
        setState( () => {
          widget.rating != index ? widget.rating = index : widget.rating = 0
        }),
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 1; i <= 5; i++)
          buildStar( i ),
      ],
    );
  }
  
}