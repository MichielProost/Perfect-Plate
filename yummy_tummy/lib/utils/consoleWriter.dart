enum documentType{
  Recipe,
  User,
  Review
}

/// Write relevant information (database & UI) to console.
class ConsoleWriter{
  /// A document was created.
  void CreatedDocument(documentType type, String documentID){
    print("NEW " + type.toString().split(".").last.toUpperCase() + " DOCUMENT: " + documentID);
  }
}