import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:track_my_tests/FileHandler.dart';

import 'DbHandler.dart';
import 'Test.dart';


class AddNewTest extends StatefulWidget{
  @override
  _AddNewTestState createState() => _AddNewTestState();
}

class _AddNewTestState extends State<AddNewTest> {

  FileHandler fileHandler = FileHandler();
  DbHandler dbHandler = DbHandler();

  File _image;
  final picker = ImagePicker();

  Future getImage() async {

    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
      title: Text("Scan a new Test..."),
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.orange[300],
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.7,
                child: (_image != null) ? Image.file(_image):
                Container(
                  padding: EdgeInsets.all(40.0),
                  child: Image.asset("assets/bermuda-646.png",

                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  SizedBox(
                    height: 80,
                    child: (_image != null )? ElevatedButton(
                          onPressed: () async{
                            final String finalPath = await fileHandler.saveImgToDevice(_image);

                            Test test  = Test(
                              id:null,
                              date: DateTime.now().toIso8601String(),
                              imgPath: finalPath
                            );

                            // create test object
                            dbHandler.insertTest(test);
                            //dbHandler.addToStream();
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/");
                            //insert into database
                            },
                          child: Text("Add to library"),

                    ):
                    RaisedButton(
                      color: Colors.grey,
                      onPressed: (){},
                      child: Text("select image"),

                    ),
                  ),

                    SizedBox(
                      height: 80,
                      child: ElevatedButton(
                            onPressed: (){
                              getImage();
                            },
                            child: Icon(Icons.add_a_photo)),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}