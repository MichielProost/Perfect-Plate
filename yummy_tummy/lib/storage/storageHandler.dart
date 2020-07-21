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

    return pickedFile == null ? null : File(pickedFile.path);

  }

  /// Upload a picture to Firestore.
  /// Only if ImageType starts with "recipe", title should be given.
  /// In all other cases, title should be an empty string.
  /// Only if ImageType is equal to ImageType.recipe_step, stepCount should be given.
  /// Otherwise, stepCount should be 0.
  /// Returns an empty string if user isn't logged in.
  Future<String> uploadPicture(File image, ImageType type, String title, int stepCount) async {

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
          path = path + Constants.appUser.name + "/recipes/" + title + "/result.jpg";
        break;
        case ImageType.recipe_step:
          path = path + Constants.appUser.name + "/recipes/" + title + "/step$stepCount.jpg";
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