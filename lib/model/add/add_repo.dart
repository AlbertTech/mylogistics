import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mylogistics/model/utility/UtilityImageModel.dart';

class AddRepository {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  UtilityImageModel addImageModel;

  Future<String> fetchText() async {
    String myStrToReturn = "";
    await firebaseFirestore
        .collection("Tester")
        .doc("ikAtsTG9sGTsxZ7o1VVz")
        .get()
        .then((value) {
      myStrToReturn = value.get("test").toString();
      return myStrToReturn;
    }).catchError((error) {
      print("my error $error");
      throw Exception("Failed");
    });
    return myStrToReturn;
  }

  Future<File> fetchImageSelected() async {
    addImageModel = new UtilityImageModel();
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    addImageModel.setFile(pickedFile);
    return addImageModel.getFile;
  }
}
