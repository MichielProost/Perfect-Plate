/// Replace char in a string at a certain index by a new one.
String replaceCharAt(String oldString, int index, String newChar) {

  return
    oldString.substring(0, index) + newChar + oldString.substring(index + 1);

}

//TODO implement better way to implement this with regards to languages
/// Get a user-ready String of an enumeration value.
String enumStringToDisplayString(String oldString){

  String lowercase = oldString.toLowerCase().split('.').last;

  /// Replaces underscore by space if present.
  if (lowercase.contains("_")){
    int index = lowercase.indexOf("_");
    lowercase = replaceCharAt(lowercase, index, " ");
  }

  return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';

}