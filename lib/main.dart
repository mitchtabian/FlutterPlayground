import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("First Flutter App"),),
        body: Text("Stuff")
      )
    );
  }

}




















class Person{

  String name;
  int age;

  Person({@required this.name, @required this.age});

}

double addNumbers(double num1, double num2){
  return num1 + num2;
}

void stuff(){
  var p1 = Person(name: "Max", age: 30);
  var p2 = Person(name: "Guy", age: 31);
  print(p1.name);
  print(p2.name);
  double firstResult = addNumbers(p1.age.toDouble(), p2.age.toDouble());
  print("The sum of their ages: " + firstResult.toString());

}










































