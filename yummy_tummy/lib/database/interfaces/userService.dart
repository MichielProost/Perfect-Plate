import 'package:yummytummy/model/user.dart';

/// INTERFACE: Required methods when changing database.
abstract class UserService{

  /// Add a new user to the database. Returns the document ID.
  Future<String> addUser(User user, String userID);

  /// Returns user object from document ID.
  Future<User> getUserFromID(String userID);

  /// Modify an existing user with a given document ID.
  Future<void> modifyUser(User user, String userID);

  /// Returns true if user exists.
  Future<bool> userExists(String userID);

  /// Listens to the app user's document for changes.
  void scoreListener();

}