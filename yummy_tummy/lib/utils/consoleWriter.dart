// Each document in Firestore belongs to a collection.
enum CollectionType{
  Recipe,
  User,
  Review
}

/// Write relevant information (database & UI) to console.
class ConsoleWriter{

  /// A document was created.
  void CreatedDocument(CollectionType type, String documentID){

    print("NEW " + type.toString().split(".").last.toUpperCase() + " DOCUMENT: " + documentID);

  }

  /// A document was fetched.
  void FetchedDocument(CollectionType type, String documentID){

    print("FETCHED " + type.toString().split(".").last.toUpperCase() + " DOCUMENT: " + documentID);

  }

}