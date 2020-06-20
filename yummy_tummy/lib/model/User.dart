enum RankType {
  beginner,
  amateur,
  professional
}

class User{
  final String name;
  final int score;
  final RankType rank;

  const User({
    this.name,
    this.score,
    this.rank,
  });

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
}