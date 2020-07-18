import 'package:flutter/material.dart';

import '../constants.dart';

class SelectableStars extends StatefulWidget {
  
  final double _size;
  final void Function(int rating) onTap;
  int rating;

  SelectableStars(this._size, {this.onTap, int startRating: 0}) : rating = startRating;

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

        // Change the look of the stars
        setState( () => {
          widget.rating != index ? widget.rating = index : widget.rating = 0
        }),

        // Perform callback
        if (widget.onTap != null)
          widget.onTap( widget.rating )
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