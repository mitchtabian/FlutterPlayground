import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "MyShop",
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          fontFamily: "Lato",
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Title"),
          ),
          body: Center(
            child: Text("some text"),
          ),
        ),
    );
  }
}





























































