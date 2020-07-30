import 'package:flutter/material.dart';
import 'package:yummytummy/database/firestore/reviewServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/reviewService.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/user_interface/components/selectable_stars.dart';
import '../constants.dart';

class CreateReviewScreen extends StatefulWidget {
  
  final String _recipeID;
  final int startingStars;
  final ReviewService _reviewService = ReviewServiceFirestore();

  CreateReviewScreen(this._recipeID, {this.startingStars: 0});

  @override
  State<StatefulWidget> createState() {
    return _CreateScreen( startingStars);
  }

}

class _CreateScreen extends State<CreateReviewScreen> {
  
  Review _review;
  int _currentStars = 0;

  _CreateScreen(int startingStars)
  {
    _currentStars = startingStars;
    _review = Review(recipeID: widget._recipeID);
  }

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 250.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            
            // Close menu row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CloseButton()
              ],
            ),
            
            // Thank you for reviewing text
            Text(
              "Thank you for reviewing this recipe!",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Spacing
            SizedBox(
              height: 5.0,
            ),

            // Select rating row
            SelectableStars(35.0, startRating: _currentStars, onTap: (rating) => _currentStars = rating,),

            // Spacing
            SizedBox(
              height: 5.0,
            ),

            // Text input
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 15.0 ),
              child: TextFormField(
                enableSuggestions: true,
                controller: _controller,
                maxLines: 10,
                decoration: InputDecoration(
                  focusColor: Constants.main,
                  hintText: "Feel free to leave your opinion here",
                  enabledBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(
                      color: Constants.text_gray,
                      width: 3.0
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Constants.main,
                      width: 3.0
                    ),
                  ),
                ),
              ),
            ),

            // Spacing
            Expanded(
              child: SizedBox(
                height: 20.0,
              ),
            ),

            // Action buttons
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  
                  // Cancel button
                  FlatButton(
                    onPressed: () => Navigator.pop(context, null), 
                    child: Text("Cancel", style: Constants.buttonStyle,),
                  ),

                  // Submit button
                  FlatButton(
                    onPressed: () {
                      // Update review
                      _review.description = _controller.text;
                      _review.rating = _currentStars;
                      _review.userMap = Constants.appUser.toCompactMap();

                      // Save review
                      widget._reviewService.addReview( _review );

                      Navigator.pop(context, null);
                    }, 
                    child: Text("Submit", style: Constants.buttonStyle,),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}