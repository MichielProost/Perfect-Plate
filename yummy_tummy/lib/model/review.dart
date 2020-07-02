class Review{

  final String id;                      // Document ID.
  final Map<String, dynamic> userMap;   // Duplicate data. Information of user.
  final String recipeID;                // Recipe ID.
  final int rating;                     // Rating from user.
  final String description;             // Description from user.

  const Review({
    this.id,
    this.userMap,
    this.recipeID,
    this.rating,
    this.description,
  });

  /// Deserialize received data from Firestore.
  /// Initialize a new review object.
  Review.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          userMap: data.containsKey('userMap') ?
            new Map<String, dynamic>.from(data['userMap']) : {},
          recipeID: data.containsKey('recipeID') ? data['recipeID'] : '',
          rating: data.containsKey('rating') ? data['rating'] : 0,
          description: data.containsKey('description') ? data['description'] : '',
      );

  /// Print summary of review to console.
  void printSummary(){
    print("Document ID: " + this.id);
    print("Recipe ID: " + this.recipeID);
    print("Rating: $rating");
  }

}