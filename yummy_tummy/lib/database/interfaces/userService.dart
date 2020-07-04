import 'package:yummytummy/model/user.dart';

/// INTERFACE: Required methods when changing database.
abstract class UserService{

  /// Add a new user to the database. Returns the document ID.
  Future<String> addUser(User user);

  /// Returns user object from document ID.
  Future<User> getUserFromID(String userID);
}