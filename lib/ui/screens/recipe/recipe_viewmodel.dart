import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RecipeViewModel extends GetxController{

  late List<File> _imageFiles;

  Future pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage();
    if(pickedFile != null){
      pickedFile.forEach((element) {_imageFiles.add(File(element.path));});
    }
  }

  uploadPictures(){

  }

  shareRecipe(){


  }




}