enum RankType {
  beginner,
  amateur,
  professional
}

class User{
  final String id;
  final String name;
  final int score;
  final RankType rank;

  const User({
    this.id,
    this.name,
    this.score,
    this.rank,
  });

  /// Returns the user's id.
  String getId(){
    return this.id;
  }

  /// Returns the user's name.
  String getName(){
    return this.name;
  }

  /// Returns the user's score.
  int getScore(){
    return this.score;
  }

  /// Returns the user's rank.
  RankType getRank(){
    return this.rank;
  }

  /// Deserialize received data from Firestore.
  /// Initialize a new user object.
  User.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          name: data['name'],
          score: data['score'],
          rank: RankType.values[data['type']],
        );
}