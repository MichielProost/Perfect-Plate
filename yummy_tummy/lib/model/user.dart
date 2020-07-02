// The Recipe and Review Class contain a UserMap.
// This map contains the most important information of the user.
enum UserMapField{
  id,
  name
}

// The rank a specific user can have.
enum RankType {
  beginner,
  amateur,
  professional
}

extension Rank on RankType {

  /// Get the corresponding rank of this index.
  /// Must be >= 0.
  /// An index that is too high will simply result in the highest rank.
  RankType getRank(int index)
  {
    return index < RankType.values.length ? RankType.values[index] : RankType.values[ RankType.values.length-1 ];
  }

  // Get a user-ready String of the rank name
  String getString()
  {
    //TODO implement better way to implement this with regards to languages
    String lowercase = this.toString().toLowerCase().split('.').last;
    return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';
  }

}

class User{

  final String id;                // Document ID.
  final String name;              // Name of user.
  final int score;                // User's total score.
  final RankType rank;            // User's rank.
  final List<String> favourites;  // Document IDs of user's favourite recipes.

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
          id: id != null ? id : data['id'],
          name: data.containsKey('name') ? data['name'] : '',
          score: data.containsKey('score') ? data['score'] : 0,
          rank: data.containsKey('Rank') ? RankType.values[data['Rank']] : RankType.beginner,
          favourites: data.containsKey('favourites') ?
            new List<String>.from(data['favourites']) : [],
        );

  /// Print summary of user to console.
  void printSummary(){
    print("Document ID: " + this.id);
    print("Name: " + this.name);
  }

}