import 'package:flutter/material.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/user_interface/components/selectable_stars.dart';

class CreateReviewScreen extends StatefulWidget {
  
  final String _recipeID;
  final int startingStars;

  CreateReviewScreen(this._recipeID, {this.startingStars: 0});

  @override
  State<StatefulWidget> createState() {
    return _CreateScreen( startingStars );
  }

}

class _CreateScreen extends State<CreateReviewScreen> {
  
  // Data
  Review _review = Review();
  int _currentStars = 0;

  _CreateScreen(int startingStars)
  {
    _currentStars = startingStars;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 50.0),
      child: Card(
        child: Column(
          children: <Widget>[
            
            // Close menu row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CloseButton()
              ],
            ),

            // Select rating row
            SelectableStars(35.0, startRating: _currentStars,),

          ],
        ),
      ),
    );
  }

}