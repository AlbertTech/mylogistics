import 'dart:io';
import 'package:image_picker/image_picker.dart';
class AddImageModel {
  File file;
  File get getFile => file;

  setFile(PickedFile pickedFile) {
    this.file = File(pickedFile.path);
    print("file path: "+pickedFile.path);
  }
}