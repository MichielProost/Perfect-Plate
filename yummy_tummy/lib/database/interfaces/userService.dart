import 'package:yummytummy/model/user.dart';

/// INTERFACE: Required methods when changing database.
abstract class UserService{

  /// Add a new [User] to the database. Returns the document ID.
  Future<String> addUser(User user, String userID);

  /// Returns [User] object from document ID [userID].
  Future<User> getUserFromID(String userID);

  /// Modify an existing [User] with a given document ID [userID].
  Future<void> modifyUser(User user, String userID);

  /// Returns true if [User] with [userID] exists.
  Future<bool> userExists(String userID);

  /// Deletes the profile picture of a [User] from storage and resets the local [User]'s profile picture.
  Future<void> deleteProfilePicture(User user);

  /// Listens to the app [User]'s document for changes.
  /// Upgrades the [User]'s [Rank] when necessary.
  void scoreListener();

}