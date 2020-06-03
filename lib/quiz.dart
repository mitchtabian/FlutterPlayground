import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

const QUESTION = "question";
const ANSWERS = "answers";
const TEXT = "text";
const SCORE = "score";

class Quiz extends StatelessWidget {

  final List<Map<String, Object>> _questions;
  final int _questionIndex;
  final Function _selectHandler;

  Quiz(this._questions, this._questionIndex, this._selectHandler);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
            _questions[_questionIndex][QUESTION]
        ),
        ...(_questions[_questionIndex][ANSWERS] as List<Map<String, Object>>).map((answer) {
          return Answer(() => _selectHandler(answer[SCORE]), answer[TEXT]);
        }).toList()
      ],
    );
  }
}





//class _MyQuizState extends State<Quiz> {
//  @override
//  Widget build(BuildContext context) {
//
//    var questionIndex = 0;
//
//    void answerQuestion(){
//      setState(() {
//        questionIndex += 1;
//      });
//    }
//
//    final List<Map<String, Object>> questions = [
//      {
//        QUESTION: "Is Coding In Flow actually my son?",
//        ANSWERS: ["Yes", "No"]
//      },
//      {
//        QUESTION: "Who's your favorite android teacher?",
//        ANSWERS: ["Coding with Mitch", "Coding In Flow", "Donn Felker", "Nate Ebel"],
//      },
//      {
//        QUESTION: "Is Flutter for babies?",
//        ANSWERS: ["Yes", "No"],
//      },
//    ];
//
//    @override
//    Widget build(BuildContext context) {
//      return questionIndex < questions.length
//          ? Column(
//        children: [
//          Question(
//              questions[questionIndex][QUESTION]
//          ),
//          ...(questions[questionIndex][ANSWERS] as List<String>).map((answer) {
//            return Answer(answerQuestion, answer);
//          }).toList()
//        ],
//      )
//          : Center(
//        child: Text("done the thing"),
//      );
//    }
//  }
//
//}



















