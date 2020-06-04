import 'package:flutter/material.dart';

import '../styles.dart';

class NewTransaction extends StatelessWidget {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function _addNewTx;

  NewTransaction(this._addNewTx);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: DefaultCardElevation,
        child: Container(
          padding: EdgeInsets.all(DefaultCardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                ),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
              ),
              FlatButton(
                child: Text("Add Transaction"),
                onPressed: (){
                  _addNewTx(titleController.text, double.parse(amountController.text));
                },
                textColor: Colors.purple,
              )
            ],
          ),
        )
    );
  }
}






















