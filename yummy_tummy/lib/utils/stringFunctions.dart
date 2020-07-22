/// Replace char in a string at a certain index by a new one.
String replaceCharAt(String oldString, int index, String newChar) {

  return
    oldString.substring(0, index) + newChar + oldString.substring(index + 1);

}