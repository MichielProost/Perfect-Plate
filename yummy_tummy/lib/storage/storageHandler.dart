import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:permission_handler/permission_handler.dart';

/// Type of images that can be stored in Firebase.
enum ImageType{
  profile,
  recipe_result,
  recipe_step,
}

class StorageHandler{

  FirebaseStorage _storage;
  StorageReference _storageReference;
  ImagePicker _picker;

  /// Constructor.
  StorageHandler(){
    _storage = FirebaseStorage.instance;
    _storageReference = _storage.ref();
    _picker = new ImagePicker();
  }

  /// Returns true if the [User] allows camera access. Returns false otherwise.
  Future<bool> checkAndRequestCameraPermissions() async {
    // TODO either remove this or integrate gathering user permission data in main.dart
    PermissionStatus previous = Constants.appUser.statuses[Permission.camera];
    if (previous != PermissionStatus.granted) {
      Constants.appUser.statuses[Permission.camera] = await Permission.camera.request();
      if (Constants.appUser.statuses[Permission.camera] != previous){
        UserServiceFirestore userService = new UserServiceFirestore();
        userService.modifyUser(Constants.appUser, Constants.appUser.id);
      }
      return Constants.appUser.statuses[Permission.camera] == PermissionStatus.granted;
    } else {
      return true;
    }
  }

  /// Get picture from [User].
  /// Returns the received [file].
  /// Returns null when something goes wrong.
  Future<File> getPicture(ImageSource source) async {

    // Redundant permission check for people who deny permissions
    if (source == ImageSource.camera)
      await Permission.camera.request();
    else
      await Permission.photos.request();

    PickedFile pickedFile = await _picker.getImage(source: source, maxWidth: 500, maxHeight: 500);

    return pickedFile == null ? null : File(pickedFile.path);

  }

  /// Upload a [file] to Firebase.
  /// [file] will be uploaded to the given [path].
  Future<String> uploadFile(File image, String path) async {

      StorageReference ref = _storageReference.child(path);

      StorageUploadTask uploadTask = ref.putFile(image);

      return await (await uploadTask.onComplete ).ref.getDownloadURL();

  }

  /// Upload all images of a specific [Recipe] with [recipeID] to Firebase.
  /// Set the appropriate image URLs in [Recipe] document.
  /// [images] : First element of list contains image banner.
  /// [images] : Other elements contain step images.
  Future<void> uploadAndSetRecipeImages(List<File> images, String recipeID) async {

    String path;
    Map<String, String> locations = Map<String, String>();
    RecipeServiceFirestore recipeService = new RecipeServiceFirestore();

    path = createImagePath(ImageType.recipe_result, recipeID, null);
    String bannerURL = await uploadFile(images[0], path);

    for (int i=1; i<images.length; i++){
      if (images[i] != null ){
        path = createImagePath(ImageType.recipe_step, recipeID, i);
        String downloadURL = await uploadFile(images[i], path);
        locations[i.toString()] = downloadURL;
      }
    }

    Recipe recipe = await recipeService.getRecipeFromID(recipeID);
    recipe.image = bannerURL;
    recipe.stepImages = locations;
    await recipeService.modifyRecipe(recipe, recipeID);

  }

  /// Upload an [image] of the logged in user to Firebase.
  /// Set the appropriate image URL in user document.
  Future<void> uploadAndSetProfileImage(File image) async {

    if (Constants.appUser.isLoggedIn()){

      UserServiceFirestore userService = new UserServiceFirestore();
      String path = createImagePath(ImageType.profile, null, null);
      Constants.appUser.image = await uploadFile(image, path);
      await userService.modifyUser(Constants.appUser, Constants.appUser.id);

    } else {
      print("ERROR: User isn't logged in.");
    }

  }

  /// Create a Firebase storage path.
  /// [type] : Type of image to store in Firebase.
  /// [recipeID] : Give the [recipeID] when dealing with [Recipe] related paths.
  /// Should be null when dealing with other paths.
  /// [stepNumber] : Give the recipe step number when dealing with step images.
  /// Should be null otherwise.
  String createImagePath(ImageType type, String recipeID, int stepNumber){

    String path = "images/" + Constants.appUser.id;
    switch (type)
    {
      case ImageType.profile:
        path = path + "/profile.png";
        break;
      case ImageType.recipe_result:
        path = path + "/$recipeID/" + "banner.png";
        break;
      case ImageType.recipe_step:
        path = path + "/$recipeID/" + "step$stepNumber.png";
    }
    return path;

  }

  /// Checks if file with [path] exists in Firebase storage.
  /// Prints an error when file doesn't exist (unavoidable).
  Future<bool> fileExists(String path) async {
    bool exists = false;
    await _storageReference.child(path).getDownloadURL().then((value){
      exists = true;
    })
    .catchError((error) {
      exists = false;
    });
    return exists;

  }

  /// Delete all images (banner + steps) of a specific [Recipe] object.
  Future<void> deleteRecipeImages(Recipe recipe) async{
    await deleteImage(recipe.image);
    var seriesList = recipe.stepImages.entries.toList();
    for (int i=0; i<recipe.stepImages.length; i++){
      await deleteImage(seriesList[i].value);
    }
  }

  /// Delete an image with [downloadURL] in Firebase storage.
  Future<void> deleteImage(String downloadURL) async {
    StorageReference imageRef = await _storage.getReferenceFromUrl(downloadURL);
    await imageRef.delete().then((value){
    }).catchError((error) {
      print("ERROR: Could not delete file with URL: " + downloadURL);
    });
  }

}