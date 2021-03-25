import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler{

  Future<String> saveImgToDevice(File image) async{
    final directory = await getApplicationDocumentsDirectory();
    final folderPath = "${directory.path}/Images";
    final dirExists = await Directory(folderPath).exists();

    if(!dirExists){
      await new Directory(folderPath).create();
      print("folder does not exist, I created one");
    }
    final fileName = basename(image.path);
    final savedImage = await image.copy("$folderPath/$fileName");
    return savedImage.path;
  }

}