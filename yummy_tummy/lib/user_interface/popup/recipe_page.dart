import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/components/rating_row.dart';
import 'package:yummytummy/user_interface/components/review_form.dart';
import 'package:yummytummy/user_interface/components/selectable_stars.dart';
import 'package:yummytummy/user_interface/general/icon_builder.dart';
import 'package:yummytummy/user_interface/popup/recipe_ratings.dart';

import '../constants.dart';

class RecipePage extends StatefulWidget {
  
  final Recipe _recipe;
  static const double BANNER_HEIGTH= 140.0;

  RecipePage(this._recipe);

  @override
  State<StatefulWidget> createState() => _RecipePageState(_recipe);
}

class _RecipePageState extends State<RecipePage> {
  final Recipe _recipe;
  //TODO properly implement favourite
  bool _isFavorite = false;

  _RecipePageState(this._recipe);


    @override
  Widget build(BuildContext context) {
    // TODO add reviews page 

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
                  shrinkWrap: true, 
                  slivers: <Widget>[

                    // Banner with image and title
                    SliverAppBar(
                      backgroundColor: Constants.main,
                      pinned: false,
                      floating: false,
                      leading: Container(),
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
                          for (int stepNumber = 0; stepNumber < _recipe.stepDescriptions.length; stepNumber++) 
                            buildExpansionTile(stepNumber)
                        ]
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
        //   // TODO add proper language system
        //   onPressed:  () => showDialog(context: context, child: InfoPopup("Description", _recipe.description, Icons.info_outline)),
        // ),

        // TODO implement timer
        // Timer button
        // IconButton(
        //   icon: Icon(
        //     Icons.timer,
        //     size: 35.0,
        //   ),
        //   onPressed: () {
        //     // TODO add timer
        //   },
        // ),

        // Share button
        IconButton(
          icon: Icon(
            Icons.share,
            size: 35.0,
          ),
          onPressed: () {
            // TODO implement actual share logic
            //Share.share( _recipe.getId() );
          },
        ),

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
              //TODO add favourite/unfavourite logic
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
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildIconInfo(Icons.fastfood, _recipe.getReadableType(), true),
                  buildIconInfoCustom(CustomIcon.vegetarian, "Vegetarian", _recipe.isVegetarian),
                ],
              ),
              SizedBox(
                width: 50.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildIconInfo(Icons.timer, _recipe.duration.toString() + "''", true),
                  buildIconInfoCustom(CustomIcon.vegan, "Vegan", _recipe.isVegan),
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
      ),
    );
  }

  /// Creates a list of ingredients for this recipe
  Widget buildIngredients() {
    List<String> ingredients = _recipe.ingredients;
    return Column(
      children: <Widget>[
        buildDivider(),
        //TODO add language system
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Ingredients",
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
    // TODO add language support
    // TODO add step image support
    return Theme(
      data: ThemeData(
        accentColor: Constants.main,
      ),
      child: ExpansionTile(
        title: Text(
          "Step " + (index + 1).toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Constants.main,
          ),
        ),
        initiallyExpanded: true,
        children: <Widget>[
          Text(
            _recipe.stepDescriptions[index],
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          //Image(),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
