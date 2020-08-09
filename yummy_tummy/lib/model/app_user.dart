import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

/// A class that contains info on a logged in user
class AppUser extends User {

  // For internal usage
  final String _googleID;

  AppUser(this._googleID, Map<String, dynamic> userData) : super.fromMap( userData, _googleID ) {
    Localization.instance.setLanguage( languagePreference );
  }

  AppUser.offline() : _googleID = "", super(id: "", name: "User", rank: RankType.values[0], score: 0, favourites: List<String>(), languagePreference: LanguagePick.english);

  /// Check if this user is logged in
  bool isLoggedIn()
  {
    return _googleID != "";
  }

}