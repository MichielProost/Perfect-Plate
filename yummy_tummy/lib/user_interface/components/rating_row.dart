import 'package:flutter/material.dart';

import '../constants.dart';

class RatingRow extends StatelessWidget {
  
  static const double DEFAULT_SIZE = 20.0;

  final double _rating;
  final int _numRatings;
  final double _ratingSize;


  /// Creates a row of stars that accurately display the given rating
  /// The rating should be in the range [0, 5]
  /// A rating smaller than 0 will result in zero filled stars, and a rating bigger than five will result in five filled stars
  RatingRow(this._rating, [this._numRatings]) : _ratingSize = DEFAULT_SIZE;
  RatingRow.withSize(this._rating, {int numRatings, double size: DEFAULT_SIZE}) : 
    _numRatings = numRatings,
    _ratingSize = size
  ;


  /// Creates an icon that follows the star guidelines but displays the given icon
  Icon _createStar(IconData icon)
  {
    return Icon(
      icon,
      size: _ratingSize,
      color: Constants.accent,
    );
  }
  

  /// Creates a List of icons that visually show the relevant rating and returns that list
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
        _createStar(Icons.star)
      );
    }

    // Add a half star if needed
    if (numHalfStars == 1 && numRemaining > 0)
    {
      numRemaining--;

      stars.add(
        _createStar(Icons.star_half)
      );
    }

    // Complete the list with missing empty stars
    while (numRemaining > 0)
    {
      numRemaining--;

      stars.add(
        _createStar(Icons.star_border)
      );
    }

    return stars;
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: _createStars(),
        ),

        if (_numRatings != null)
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            size: _ratingSize,
          ),
        ),

        if (_numRatings != null)
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Text(
            _numRatings.toString()
          ),
        ),
      ],
    );
  }

}