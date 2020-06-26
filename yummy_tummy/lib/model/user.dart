// Fields in UserMap.
// Map is used in other classes to specify a specific user.
enum UserMapField{
  id,
  name
}

// User can be classified into a rank.
enum RankType {
  beginner,
  amateur,
  professional
}

/// User object. Initialized with User.fromMap method.
class User{
  final String id;                // Document ID.
  final String name;              // Name of user.
  final int score;                // User's total score.
  final RankType rank;            // User's rank.
  final List<String> favourites;  // Document IDs of favourite recipes.

  const User({
    this.id,
    this.name,
    this.score,
    this.rank,
    this.favourites,
  });

  /// Deserialize received data from Firestore.
  /// Initialize a new user object.
  User.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          name: data['name'],
          score: data['score'],
          rank: RankType.values[data['type']],
          favourites: new List<String>.from(data['favourites']),
        );

  /// Print summary of user to console.
  void printSummary(){
    print("Document ID: " + this.id);
    print("Name: " + this.name);
  }
}