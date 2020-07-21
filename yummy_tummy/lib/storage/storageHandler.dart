import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/constants.dart';

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

    return File(pickedFile.path);

  }

  /// Upload a picture to Firestore.
  /// Only if ImageType starts with "recipe", recipe object should be given.
  /// In all other cases, recipe object should be null.
  /// Returns an empty string if user isn't logged in.
  Future<String> uploadPicture(File image, ImageType type, Recipe recipe) async {

    // User must be logged in.
    if(Constants.appUser.isLoggedIn())
    {
      String path = "images/";
      switch (type)
      {
        case ImageType.profile:
          path = path + Constants.appUser.name + "/profilePicture.jpg";
        break;
        case ImageType.recipe_result:
          path = path + recipe.id + "/result.jpg";
        break;
        case ImageType.recipe_step:
          // Don't know yet.
      }

      StorageReference ref = _storageReference.child(path);

      StorageUploadTask uploadTask = ref.putFile(image);

      return await (await uploadTask.onComplete ).ref.getDownloadURL();
    }
    else {
      return "";
    }

  }

}