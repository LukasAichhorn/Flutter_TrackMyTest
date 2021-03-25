import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Test.dart';

class DbHandler {
  StreamController<List<Test>> controller = StreamController<List<Test>>();
  DbHandler();

  Future<void> handleDatabase() async {

    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), "CoronaTest.db"),
      onCreate: (db,version){
        print("DBHandler Class --> inside on Create ");
        return db.execute("CREATE TABLE tests(id INTEGER PRIMARY KEY, createdAt TEXT, imgPath TEXT)",
        );
      },
      version:1
      ,
    );
    print("DBHandler Class --> open Database ");
  }

  Future<void>insertTest(Test test) async {
    final Database db = await openDatabase(join(await getDatabasesPath(),"CoronaTest.db"));
    try {
      await db.insert(
        "tests",
        test.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    catch(e){
      print("$e");
    }

  }
  Future<List<Test>> getTests() async{
    final Database db = await openDatabase(join(await getDatabasesPath(),"CoronaTest.db"));
    final List<Map<String,dynamic>> maps = await db.query("tests");
    return List.generate(maps.length, (i){
      return Test(

        date: maps[i]["createdAt"],
        imgPath: maps[i]["imgPath"]
      );
    });
  }
  void addToStream(){
    getTests().then((tests){
      controller.add(tests);

    });

  }
  


}