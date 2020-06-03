import 'package:flutter/material.dart';

class Result extends StatelessWidget {

  final int resultScore;
  final Function _resetQuizHandler;

  Result(this.resultScore, this._resetQuizHandler);

  String get resultPhrase {
    if(resultScore < 2){
      return "Your score was $resultScore.\nThat's terrible.";
    }
    else if(resultScore >= 2 && resultScore < 5){
      return "Your score was $resultScore.\nWith a little work you'll have a great score.";
    }
    else{
      return "Your score was $resultScore.\nThat's a great score!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children:[
              Text(
                resultPhrase,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            FlatButton(
              child: Text("Restart Quiz!"),
              onPressed: _resetQuizHandler,
              textColor: Colors.blue,
            )
          ],
        ),
    );
  }
}
