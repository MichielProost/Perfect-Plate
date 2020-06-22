import 'package:flutter/material.dart';

class RatingRow extends StatelessWidget {
  
  final double _rating;

  /// Creates a row of stars that accurately display the given rating
  /// The rating must be in the range [0, 5]
  /// A rating smaller than 0 will result in zero filled stars, and a rating bigger than five will result in five filled stars
  RatingRow(this._rating);

  List<Widget> _createStars()
  {
    List<Widget> stars = new List<Widget>();

    // Calculate the amount of half stars -> Two half stars should be a full one
    int numHalfStars = (_rating * 2).round();
    int numRemaining = 5; // The amount of remaining stars

    // Add the full stars to the list
    while (numHalfStars >= 2 && numRemaining > 0)
    {
      numHalfStars -= 2;
      numRemaining--;

      stars.add(
        Icon(Icons.star)
      );
    }

    // Add a half star if needed
    if (numHalfStars == 1 && numRemaining > 0)
    {
      numRemaining--;

      stars.add(
        Icon(Icons.star_half)
      );
    }

    // Complete the list with missing empty stars
    while (numRemaining > 0)
    {
      numRemaining--;

      stars.add(
        Icon(Icons.star_border)
      );
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _createStars(),
    );
  }

}