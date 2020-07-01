// Recipes are classified in one of many types.
enum RecipeType {
  soups,
  salads,
  mains,
  desserts
}

class Recipe {

  final String id;                      // Document ID.
  final String title;                   // Title of recipe.
  final String description;             // Main description.
  final RecipeType type;                // Type of recipe.
  final bool isVegetarian;              // Vegetarian recipe?
  final bool isVegan;                   // Vegan recipe?
  final List<String> ingredients;       // Ingredients.
  final List<String> stepDescriptions;  // A list of descriptions. Each element represents a step.
  final List<String> stepImages;        // Image URL of each step.
  final double rating;                  // Rating of dish.
  final int duration;                   // How long it takes to make the recipe.
  final String image;                   // Image URL of result.
  final int numberOfReviews;            // Number of reviews.
  final Map<String, dynamic> userMap;   // Duplicate data. Information of user.

  const Recipe({
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
          isVegan: data['isVegan'],
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