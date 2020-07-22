import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/constants.dart';

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

  /// Get picture from user.
  Future<File> getPicture(ImageSource source) async {

    PickedFile pickedFile = await _picker.getImage(source: source);

    return pickedFile == null ? null : File(pickedFile.path);

  }

  /// Upload a file to Firebase.
  /// File will be uploaded to the given path.
  Future<String> uploadFile(File image, String path) async {

      StorageReference ref = _storageReference.child(path);

      StorageUploadTask uploadTask = ref.putFile(image);

      return await (await uploadTask.onComplete ).ref.getDownloadURL();

  }

  /// Upload all images of a specific recipe to Firebase.
  /// Set the appropriate image URLs in recipe document.
  /// images: First element of list contains image banner.
  /// images: Other elements contain step images.
  Future<void> uploadAndSetRecipeImages(List<File> images, String recipeID) async {

    String path;
    List<String> locations = List<String>();
    RecipeServiceFirestore recipeService = new RecipeServiceFirestore();

    path = createImagePath(ImageType.recipe_result, recipeID, null);
    String bannerURL = await uploadFile(images[0], path);

    for (int i=1; i<images.length; i++){

      path = createImagePath(ImageType.recipe_step, recipeID, i);
      String downloadURL = await uploadFile(images[i], path);
      locations.add(downloadURL);

    }

    Recipe recipe = await recipeService.getRecipeFromID(recipeID);
    recipe.image = bannerURL;
    recipe.stepImages = locations;
    await recipeService.modifyRecipe(recipe, recipeID);

  }

  /// Upload an image of the logged in user to Firebase.
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
  /// type: Type of image to store in Firebase.
  /// recipeID: Give the recipe ID when dealing with recipe related paths.
  /// Should be null when dealing with other paths.
  /// stepNumber: Give the recipe step number when dealing with step images.
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

  /// Checks if file exists in Firebase storage.
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

}