import 'package:flutter/material.dart';
import 'package:yummytummy/database/buffer/User_content_buffer.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/user_interface/components/rating_row.dart';
import 'package:yummytummy/user_interface/components/review_card.dart';
import 'package:yummytummy/user_interface/components/selectable_stars.dart';
import 'package:yummytummy/user_interface/general/icon_builder.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
import 'package:yummytummy/user_interface/popup/create_review.dart';
import 'package:yummytummy/user_interface/popup/info_popup.dart';
import 'package:yummytummy/user_interface/popup/recipe_ratings.dart';
import 'package:yummytummy/user_interface/popup/widget_popup.dart';
import 'package:yummytummy/user_interface/widgets/better_expansion_tile.dart';

import '../constants.dart';

class RecipePage extends StatefulWidget {
  
  final Recipe _recipe;
  static const double BANNER_HEIGTH= 140.0;

  RecipePage(this._recipe);

  @override
  State<StatefulWidget> createState() => _RecipePageState(_recipe);
}

class _RecipePageState extends State<RecipePage> {
  
  final UserServiceFirestore userService = new UserServiceFirestore();
  final Recipe _recipe;
  bool _isFavorite;
  

  _RecipePageState(this._recipe) {
    _isFavorite = Constants.appUser.favourites.contains( _recipe.id );
  }


  @override
  Widget build(BuildContext context) {

    RatingRow ratingView = RatingRow(_recipe.rating, _recipe.numberOfReviews);

    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              
              // Button bar for user
              buildButtonBar(),

              Padding(
                padding: const EdgeInsets.only(bottom: 3.0, left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () => showDialog(context: context, child: RecipeRatings( _recipe.id, ratingView )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
                        child: ratingView,
                      ),
                    ),
                    Text(_recipe.userMap['name']),
                  ],
                ),
              ),

              // Scrollable recipe
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[

                    // Banner with image and title
                    SliverAppBar(
                      backgroundColor: Constants.main,
                      pinned: false,
                      floating: true,
                      leading: Container(),
                      forceElevated: true,
                      expandedHeight: RecipePage.BANNER_HEIGTH,
                      flexibleSpace: FlexibleSpaceBar(
                        title: buildTitle(),
                        background: buildBackground(),
                      ),
                    ),


                    // Summary text
                    SliverToBoxAdapter(
                      child: buildIntroText(),
                    ),

                    // Info panel with recipe type, prep time, diet, ...
                    SliverToBoxAdapter(
                      child: buildInfoPanel(),
                    ),

                    // Ingredient list
                    SliverToBoxAdapter(
                      child: buildIngredients(),
                    ),

                    // Show all steps
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          // for (int x = 0; x < 20; x++) 
                          for (int stepNumber = 0; stepNumber < _recipe.stepDescriptions.length; stepNumber++) 
                            buildExpansionTile(stepNumber)
                        ]
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: <Widget>[
                            Text( Localization.instance.language.getMessage( 'please_leave_review' ) ),
                            SelectableStars(
                              35.0,
                              onTap: ( rating ) async {
                                List<Review> reviews = await UserContentBuffer.instance.getUserReviews( Constants.appUser );
                                
                                Review userReview;

                                for (Review review in reviews)
                                  if (review.recipeID == _recipe.id)
                                    userReview = review;

                                if (userReview == null)
                                  showDialog(context: context, child: CreateReviewScreen(_recipe.id, startingStars: rating,));
                                else
                                  showDialog(context: context, child: WidgetPopup(
                                    ReviewCard( userReview )
                                  ));
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),

              // Recipe info: ingrediënts and steps
              //  Container(
              //    height: MediaQuery.of(context).size.height,
              //    width: MediaQuery.of(context).size.width,
              //    child: ListWheelScrollView(
              //       itemExtent: 3,
              //       children: <Widget>[
              //         for (int i= 0; i < steps.length; i++)
              //           Text("Placeholder"),
              //           //buildStepWidget(i, steps[i]),
              //       ],
              //     ),
              //  ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildTitle()
  {
    return Text(
      _recipe.title,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        //backgroundColor: Colors.white,
        fontWeight: FontWeight.bold,
        shadows: <Shadow>[
          Shadow(blurRadius: 10.0),
        ],
      ),
    );
  }


  Widget buildBackground()
  {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: RecipePage.BANNER_HEIGTH,
        width: double.infinity,
        child: Image(image: NetworkImage(_recipe.image), fit: BoxFit.fitWidth),
      ),
    );
  }


  /// Generate the banner for this recipe
  Widget buildBanner() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        // Image component
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            height: RecipePage.BANNER_HEIGTH,
            width: double.infinity,
            child: Image(image: NetworkImage(_recipe.image), fit: BoxFit.fitWidth),
          ),
        ),

        // Text component
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            _recipe.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 27.0,
              //backgroundColor: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(blurRadius: 10.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDivider()
  {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: Constants.gray,
    );
  }

  /// Builds a Widget that contains an introduction text
  Widget buildIntroText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Text(
        _recipe.description,
        textAlign: TextAlign.justify,
      ),
    );
  }

  /// Build an information icon with one-word description which gets enabled/disabled colors
  Widget buildIconInfoCustom(CustomIcon icon, String text, bool isTrue) {
    Color color = isTrue ? Constants.green : Constants.gray;
    return buildIconInfoByIcon(IconBuilder(icon, color: color), text, color);
  }

  /// Build an information icon with one-word description which gets enabled/disabled colors
  Widget buildIconInfo(IconData icon, String text, bool isTrue) {
    Color color = isTrue ? Constants.green : Constants.gray;
    return buildIconInfoByIcon(Icon(icon, color: color), text, color);
  }

  /// Build an information icon with one-word description which gets enabled/disabled colors
  Widget buildIconInfoByIcon(Widget icon, String text, Color textColor) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: icon,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget buildButtonBar()
  {
    return
    Row(
      children: <Widget>[
        // IconButton(
        //   icon: Icon(
        //     Icons.info_outline,
        //     size: 35.0,
        //   ),
        //   onPressed:  () => showDialog(context: context, child: InfoPopup("Description", _recipe.description, Icons.info_outline)),
        // ),

        // TODO implement sharing
        // Share button
        // IconButton(
        //   icon: Icon(
        //     Icons.share,
        //     size: 35.0,
        //   ),
        //   onPressed: () {
        //     // TODO implement actual share logic
        //     //Share.share( _recipe.getId() );
        //     // Update medal.
        //     if ( !Constants.appUser.board.seriesMap['share'].isFinished() ){
        //       Constants.appUser.board.seriesMap['share']
        //           .checkCurrentMedalAchieved([]);
        //     }
        //   },
        // ),

        // Bookmark button
        IconButton(
            icon: Icon(
              _isFavorite ? Icons.bookmark : Icons.bookmark_border,
              size: 35.0,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              
              // Modify app user.
              if(_isFavorite){
                Constants.appUser.favourites.add(_recipe.id);
              } else {
                Constants.appUser.favourites.remove(_recipe.id);
              }
              // Modify user document.
              userService.modifyUser(Constants.appUser, Constants.appUser.id);

            }),

        // Provide space between icons
        Expanded(
          child: SizedBox(
            height: 1.0,
            width: 1.0,
          ),
        ),

        // Close recipe button
        CloseButton(),
      ],
    );
  }

  /// Creates an info panel about this recipe
  /// Indicates properties
  Widget buildInfoPanel() {
    return Column(
      children: <Widget>[
        buildDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildIconInfo(Icons.fastfood, _recipe.getReadableType(), true),
                  buildIconInfoCustom(CustomIcon.vegetarian, Localization.instance.language.dietFieldName( DietField.vegetarian ), _recipe.isVegetarian),
                ],
              ),
              SizedBox(
                width: 50.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildIconInfo(Icons.timer, _recipe.duration.toString() + "''", true),
                  buildIconInfoCustom(CustomIcon.vegan, Localization.instance.language.dietFieldName( DietField.vegan ), _recipe.isVegan),
                ],
              ),
            ],
          ),
        ),
        buildDivider(),
      ],
    );
  }

  /// Builds the ingredient item of this index to be displayed
  Widget buildIngredientItem(int index)
  {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        _recipe.ingredients[index],
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Creates a list of ingredients for this recipe
  Widget buildIngredients() {
    List<String> ingredients = _recipe.ingredients;
    return Column(
      children: <Widget>[
        buildDivider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Localization.instance.language.getMessage( 'ingredients' ),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < ingredients.length; i+=2)
                  buildIngredientItem(i),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 1; i < ingredients.length; i+=2)
                  buildIngredientItem(i),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        buildDivider(),
      ],
    );
  }

  /// Create an ExpansionTile for the step with given index
  Widget buildExpansionTile(int index) {
    print(_recipe.stepImages);
    return Theme(
      data: ThemeData(
        accentColor: Constants.main,
      ),
      child: BetterExpansionTile(
        title: Text(
          Localization.instance.language.getMessage( 'step' ) + ' ' + (index + 1).toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        initiallyExpanded: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _recipe.stepDescriptions[index],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          if(_recipe.stepImages.containsKey( index.toString() ))
            Image.network( 
              _recipe.stepImages[index.toString()],
              fit: BoxFit.fitWidth,
            ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
