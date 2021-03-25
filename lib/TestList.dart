import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:track_my_tests/DbHandler.dart';
import 'package:track_my_tests/FileHandler.dart';
import 'package:track_my_tests/Test.dart';

class TestList extends StatefulWidget{
  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {

  DbHandler dbHandler = DbHandler();


    
    
  @override
  Widget build(BuildContext context) {
    Stream stream = dbHandler.controller.stream;
    dbHandler.handleDatabase();

    dbHandler.addToStream();


    return StreamBuilder(
        stream: stream,
        builder:(BuildContext context, snapshot){
          if(snapshot.hasError){
            print(snapshot.error);
          }
          if(snapshot.hasData){

            print (snapshot.data);
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder:(context, index){
                  Test test = snapshot.data[index];
                  return ListTile(
                    leading: Image.file(File(test.imgPath)),
                    title: Text(test.date),
                    trailing:IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: (){

                      },
                    ),



                  );
                });
          }
          print("do i work?");
          return Text("testing");
        }
    );
  }

}