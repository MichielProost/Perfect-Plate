// Recipe can be classified into a type.
enum RecipeType {
  soups,
  salads,
  mains,
  desserts
}

/// Recipe object. Initialized with Recipe.fromMap method.
class Recipe {
  final String id;                      // Document ID.
  final String title;                   // Title of recipe.
  final String description;             // Main description.
  final RecipeType type;                // Type of recipe.
  final bool isVegetarian;              // Vegetarian recipe?
  final List<String> ingredients;       // Used ingredients.
  final List<String> stepDescriptions;  // Contains description of each step.
  final List<String> stepImages;        // Contains image URL of each step.
  final double rating;                  // Rating of dish.
  final int duration;                   // How long does it take to make the recipe.
  final String image;                   // Image URL of result.
  final int numberOfReviews;            // Number of reviews.
  final Map<String, dynamic> userMap;   // Map with user information.

  const Recipe({
    this.id,
    this.title,
    this.description,
    this.type,
    this.isVegetarian,
    this.ingredients,
    this.stepDescriptions,
    this.stepImages,
    this.rating,
    this.duration,
    this.image,
    this.numberOfReviews,
    this.userMap,
  });

  /// Deserialize received data from database.
  /// Initialize a new recipe object.
  Recipe.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          title: data['title'],
          description: data['description'],
          type: RecipeType.values[data['type']],
          isVegetarian: data['isVegetarian'],
          ingredients: new List<String>.from(data['ingredients']),
          stepDescriptions: new List<String>.from(data['stepDescriptions']),
          stepImages: new List<String>.from(data['stepImages']),
          rating: data['rating'],
          duration: data['duration'],
          image: data['image'],
          numberOfReviews: data['numberOfReviews'],
          userMap: new Map<String, dynamic>.from(data['userMap']),
        );

  /// Print summary of recipe to console.
  void printSummary(){
    print("Document ID: " + this.id);
    print("Title: " + this.title);
    print("Description: " + this.description);
  }
}