import 'dart:collection';

import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz(){
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score){
    _totalScore += score;
    setState(() {
      _questionIndex += 1;
    });
    print("score: " + _totalScore.toString());
  }

  final List<Map<String, Object>> _questions = [
    {
      QUESTION: "Is Coding In Flow actually my son?",
      ANSWERS: [
        {"text": "Yes", "score": 1},
        {"text": "No", "score": 0}
        ]
    },
    {
      QUESTION: "Who's your favorite android teacher?",
      ANSWERS: [
        {"text": "Coding with Mitch", "score": 1},
        {"text": "Coding In Flow", "score": 2},
        {"text": "Donn Felker", "score": 3},
        {"text": "Nate Ebel", "score": 4},
      ]
    },
    {
      QUESTION: "Is Flutter for babies?",
      ANSWERS: [
        {"text": "Yes", "score": 1},
        {"text": "No", "score": 0}
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("First Flutter App"),),
        body: _questionIndex < _questions.length
            ? Quiz(_questions, _questionIndex, _answerQuestion)
            : Result(_totalScore, _resetQuiz),
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










































