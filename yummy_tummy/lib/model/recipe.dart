import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

// Recipes can be sorted by the following fields.
enum SortField {
  weightedRating,
  rating,
  timestamp,
}

// Recipes can be filtered by a specific diet.
enum DietField {
  any,
  vegan,
  vegetarian,
}

// Recipes are classified in one of many types.
enum RecipeType {
  any,
  soups,
  salads,
  mains,
  desserts,
  drinks
}

extension Type on RecipeType {
  // Get a user-ready String of the rank name
  String getString()
  {
    String lowercase = this.toString().toLowerCase().split('.').last;
    return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';
  }
}

extension Diet on DietField {
  // Get a user-ready String of the rank name
  String getString()
  {
    String lowercase = this.toString().toLowerCase().split('.').last;
    return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';
  }
}

class Recipe {

  final String id;                      // Document ID.
  final Timestamp timestamp;            // Timestamp.
  String title;                         // Title of recipe.
  String description;                   // Main description.
  RecipeType type;                      // Type of recipe.
  LanguagePick language;                // Language that the recipe is written in.
  bool isVegetarian;                    // Vegetarian recipe?
  bool isVegan;                         // Vegan recipe?
  final List<String> ingredients;       // Ingredients.
  final List<String> stepDescriptions;  // A list of descriptions. Each element represents a step.
  Map<String, String> stepImages;       // Step images.
  double rating;                        // Rating of dish.
  double weightedRating;                // Weighted rating.
  int duration;                         // How long it takes to make the recipe.
  String image;                         // Image URL of result.
  int numberOfReviews;                  // Number of reviews.
  final User user;                      // User object.
  Map<String, dynamic> userMap;         // Duplicate data. Information of user.

  Recipe.editable(
    this.id,
    this.timestamp,
    this.user, 
    this.userMap,
    {
      this.title,
      this.description,
      this.type,
      this.language,
      this.isVegetarian,
      this.isVegan,
      this.rating,
      this.weightedRating,
      this.numberOfReviews,
    }
  ): 
    ingredients = List<String>(),
    stepDescriptions = List<String>(),
    stepImages = Map<String, String>();

  Recipe({
    this.id,
    this.timestamp,
    this.title,
    this.description,
    this.type,
    this.language,
    this.isVegetarian,
    this.isVegan,
    this.ingredients,
    this.stepDescriptions,
    this.stepImages,
    this.rating,
    this.weightedRating,
    this.duration,
    this.image,
    this.numberOfReviews,
    this.user,
    this.userMap,
  });

  /// Deserialize received [data] from database.
  /// Initialize a new [Recipe] object.
  Recipe.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          timestamp: data.containsKey('timestamp') ? data['timestamp'] : new Timestamp.now(),
          title: data.containsKey('title') ? data['title'] : '',
          description: data.containsKey('description') ? data['description'] : '',
          type: data.containsKey('type') ? RecipeType.values[data['type']] : RecipeType.any,
          language: data.containsKey('language') ? LanguagePick.values[data['language']] : LanguagePick.english,
          isVegetarian: data.containsKey('isVegetarian') ? data['isVegetarian'] : false,
          isVegan: data.containsKey('isVegan') ? data['isVegan'] : false,
          ingredients: data.containsKey('ingredients') ?
            new List<String>.from(data['ingredients']) : [],
          stepDescriptions: data.containsKey('stepDescriptions') ?
            new List<String>.from(data['stepDescriptions']) : [],
          stepImages: data.containsKey('stepImages') ?
            new Map<String, String>.from( data['stepImages'] ) : {},
          rating: data.containsKey('rating') ? data['rating'].toDouble() : 0.0,
          weightedRating : data.containsKey('weightedRating') ? data['weightedRating'].toDouble() : 0.0,
          duration: data.containsKey('duration') ? data['duration']: 0,
          image: data.containsKey('image') ? data['image'] : '',
          numberOfReviews: data.containsKey('numberOfReviews') ? data['numberOfReviews'] : 0,
          userMap: data.containsKey('userMap') ?
            Map<String, dynamic>.from( data['userMap'] ) : {},
          user: data.containsKey('userMap') ?
            User.fromMap( Map<String, dynamic>.from(data['userMap']), null) : User(id: '', name: '', rank: RankType.dishwasher),
        );

  /// Convert class object to data structure 'Map'.
  Map<String, dynamic> toMap() {
    return {
      'timestamp' : timestamp != null ? timestamp : new Timestamp.now(),
      'title' : title ??= '',
      'description' : description ??= '',
      'type' : type != null ? type.index : RecipeType.any.index,
      'language' : language != null ? language.index : LanguagePick.english.index,
      'isVegetarian' : isVegetarian ??= false,
      'isVegan' : isVegan ??= false,
      'ingredients' : ingredients != null ? ingredients : [],
      'stepDescriptions' : stepDescriptions != null ? stepDescriptions : [],
      'stepImages' : stepImages != null ? stepImages : {},
      'rating' : rating != null ? rating : 0.0,
      'weightedRating' : weightedRating != null ? weightedRating : 0.0,
      'duration' : duration ??= 0,
      'image' : image ??= '',
      'numberOfReviews' : numberOfReviews != null ? numberOfReviews : 0,
      'userMap' : userMap != null ? userMap : {} ,
    };
  }

  /// Convert the RecipeType field to a readable format where the first letter is uppercase and return it.
  String getReadableType() {
    String lowercase = type.toString().toLowerCase().split('.')[1];
    return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';
  }

  /// Print summary of [Recipe] to console.
  void printSummary(){
    print("Document ID: " + this.id);
    print("Date: " + this.timestamp.toDate().toString());
    print("Title: " + this.title);
  }

}