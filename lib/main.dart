import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'AddNewTest.dart';
import 'TestList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: "/",
      routes: {
        "/" : (context) => MyHomePage(),
        "/AddNewTest" : (context) => AddNewTest(),
    },
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),

      body: TestList(),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.pushNamed(context, "/AddNewTest");
      },
      child: Icon(Icons.add),
    ),
    );
  }
}
