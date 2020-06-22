import 'package:flutter/material.dart';

class RatingRow extends StatelessWidget {
  
  final double _rating;

  /// Creates a row of stars that accurately display the given rating
  /// The rating must be in the range [0, 5]
  /// A rating smaller than 0 will result in zero filled stars, and a rating bigger than five will result in five filled stars
  RatingRow(this._rating);

  /// Get the amount of stars this rating row should get
  /// Will be a multiple of 0.5
  double _getNumStars()
  {
    for (double i = 0; i < 5; i += 0.5)
    {
      if (i >= _rating)
        return i;
    }
    return 5;
  }

  List<Widget> _getStars()
  {
    List<Widget> stars = new List<Widget>();
  }

  @override
  Widget build(BuildContext context) {
    double numStars = _getNumStars();
    return Row(
      children: _getStars(),
    );
  }

}