import 'package:flutter/material.dart';

import '../styles.dart';

class NewTransaction extends StatefulWidget {

  final Function _addNewTx;

  NewTransaction(this._addNewTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  _submitData(){
    final enteredTitle = titleController.text;
    if(amountController.text.isEmpty){
      return;
    }
    final enteredAmount = double.parse(amountController.text);
    if(enteredTitle.isEmpty || enteredAmount <= 0){
      return;
    }
    widget._addNewTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

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
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              FlatButton(
                child: Text("Add Transaction"),
                onPressed: (){
                  _submitData();
                },
                textColor: Colors.purple,
              )
            ],
          ),
        )
    );
  }
}






















