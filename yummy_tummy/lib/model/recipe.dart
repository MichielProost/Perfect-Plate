enum RecipeType {
  breakfast,
  lunch,
  dinner,
  desserts,
}

class Recipe {
  final String id;
  final String title;
  final double _rating;
  final String description;
  final RecipeType type;
  final bool isVegetarian;
  final int duration;
  final List<String> ingredients;
  final String imageURL;

  const Recipe({
    this.id,
    this.title,
    double rating: 0.0,
    this.description,
    this.type,
    this.isVegetarian,
    this.duration,
    this.ingredients,
    this.imageURL,
  }) : _rating = rating;

  /// Returns the recipe's id.
  String getId(){
    return this.id;
  }

  /// Returns the recipe's title.
  String getTitle(){
    return this.title;
  }

  /// Returns the average rating for this recipe
  double getRating()
  {
    return _rating;
  }

  /// Returns the recipe's description.
  String getDescription(){
    return this.description;
  }

  /// Returns the recipe's type.
  RecipeType getType(){
    return this.type;
  }

  /// Returns true when recipe is vegetarian.
  bool getIsVegetarian(){
    return this.isVegetarian;
  }

  /// Returns the recipe's duration.
  int getDuration(){
    return this.duration;
  }

  /// Returns a list of the recipe's ingredients.
  List<String> getIngredients(){
    return this.ingredients;
  }

  /// Returns the image URL of the recipe.
  String getImageURL(){
    return this.imageURL;
  }

  /// Deserialize received data from Firestore.
  /// Initialize a new recipe object.
  Recipe.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          title: data['title'],
          description: data['description'],
          type: RecipeType.values[data['type']],
          isVegetarian: data['isVegetarian'],
          duration: data['duration'],
          ingredients: new List<String>.from(data['ingredients']),
          imageURL: data['imageURL'],
        );
}