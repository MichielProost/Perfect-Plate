import 'package:yummytummy/model/user.dart';

/// INTERFACE: Same methods are issued when changing database.
abstract class UserService{
  /// Add new user to Firestore database.
  Future<String> addUser(User user);
}