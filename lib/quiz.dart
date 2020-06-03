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




















