import 'package:flutter/cupertino.dart';
import 'package:yummytummy/model/user.dart';

// Recipes can be sorted by the following fields.
// TODO add advanced sort system: formula that combines rating and numberofreviews (and normalizes the result)
enum SortField {
  rating,
  numberOfReviews,
}

// Recipes can be filtered by a specific diet.
enum DietField {
  none,
  vegan,
  vegetarian,
}

// Recipes are classified in one of many types.
enum RecipeType {
  none,
  soups,
  salads,
  mains,
  desserts
}

extension Type on RecipeType {
  // Get a user-ready String of the rank name
  String getString()
  {
    //TODO implement better way to implement this with regards to languages
    String lowercase = this.toString().toLowerCase().split('.').last;
    return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';
  }
}

extension Diet on DietField {
  // Get a user-ready String of the rank name
  String getString()
  {
    //TODO implement better way to implement this with regards to languages
    String lowercase = this.toString().toLowerCase().split('.').last;
    return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';
  }
}

class Recipe {

  final String id;                      // Document ID.
  String title;                         // Title of recipe.
  String description;                   // Main description.
  RecipeType type;                      // Type of recipe.
  bool isVegetarian;                    // Vegetarian recipe?
  bool isVegan;                         // Vegan recipe?
  final List<String> ingredients;       // Ingredients.
  final List<String> stepDescriptions;  // A list of descriptions. Each element represents a step.
  final List<String> stepImages;        // Image URL of each step.
  final double rating;                  // Rating of dish.
  int duration;                         // How long it takes to make the recipe.
  String image;                         // Image URL of result.
  final int numberOfReviews;            // Number of reviews.
  // TODO watch out!! User is mutable, and can be edited from anywhere!
  final User user;                      // User object.
  final Map<String, dynamic> userMap;   // Duplicate data. Information of user.

  Recipe.editable(
    this.id, 
    this.user, 
    this.userMap,
    {
      this.title,
      this.description,
      this.type,
      this.isVegetarian,
      this.isVegan,
    }
  ): 
    ingredients = List<String>(),
    stepDescriptions = List<String>(),
    stepImages = List<String>(),
    rating = 0.0,
    numberOfReviews = 0;

  Recipe({
    this.id,
    this.title,
    this.description,
    this.type,
    this.isVegetarian,
    this.isVegan,
    this.ingredients,
    this.stepDescriptions,
    this.stepImages,
    this.rating,
    this.duration,
    this.image,
    this.numberOfReviews,
    this.user,
    this.userMap,
  });

  /// Deserialize received data from database.
  /// Initialize a new recipe object.
  Recipe.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          title: data.containsKey('title') ? data['title'] : '',
          description: data.containsKey('description') ? data['description'] : '',
          type: data.containsKey('type') ? RecipeType.values[data['type']] : RecipeType.none,
          isVegetarian: data.containsKey('isVegetarian') ? data['isVegetarian'] : false,
          isVegan: data.containsKey('isVegan') ? data['isVegan'] : false,
          ingredients: data.containsKey('ingredients') ?
            new List<String>.from(data['ingredients']) : [],
          stepDescriptions: data.containsKey('stepDescriptions') ?
            new List<String>.from(data['stepDescriptions']) : [],
          stepImages: data.containsKey('stepImages') ?
            new List<String>.from(data['stepImages']) : [],
          rating: data.containsKey('rating') ? data['rating'] : 0.0,
          duration: data.containsKey('duration') ? data['duration']: 0,
          image: data.containsKey('image') ? data['image'] : '',
          numberOfReviews: data.containsKey('numberOfReviews') ? data['numberOfReviews'] : 0,
          userMap: data.containsKey('userMap') ?
            Map<String, dynamic>.from( data['userMap'] ) : {},
          user: data.containsKey('userMap') ?
            User.fromMap( Map<String, dynamic>.from(data['userMap']), null) : User(id: '', name: '', rank: RankType.amateur),
        );

  /// Convert class object to data structure 'Map'.
  Map<String, dynamic> toMap() {
    return {
      'title' : title ??= '',
      'description' : description ??= '',
      'type' : type.index != null ? type.index : RecipeType.none,
      'isVegetarian' : isVegetarian ??= false,
      'isVegan' : isVegan ??= false,
      'ingredients' : ingredients != null ? ingredients : [],
      'stepDescriptions' : stepDescriptions != null ? stepDescriptions : [],
      'stepImages' : stepImages != null ? stepImages : [],
      'rating' : rating != null ? rating : 0.0,
      'duration' : duration ??= 0,
      'image' : image ??= '',
      'numberOfReviews' : numberOfReviews != null ? numberOfReviews : 0,
      'userMap' : userMap != null ? userMap : {} ,
    };
  }

  /// Convert the RecipeType field to a readable format where the first letter is uppercase and return it
  String getReadableType() {
    //TODO Better way to retreive a display name of this type (multiple languages)
    String lowercase = type.toString().toLowerCase().split('.')[1];
    return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';
  }

  /// Print summary of recipe to console.
  void printSummary(){
    print("Document ID: " + this.id);
    print("Title: " + this.title);
    print("Description: " + this.description);
  }

}