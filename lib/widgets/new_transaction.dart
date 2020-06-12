import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styles.dart';

class NewTransaction extends StatefulWidget {

  final Function _addNewTx;

  NewTransaction(this._addNewTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  
  _presentDatePicker(BuildContext ctx){
    showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  _submitData(){
    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    if(_amountController.text.isEmpty){
      return;
    }
    final enteredAmount = double.parse(_amountController.text);
    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
      return;
    }
    widget._addNewTx(enteredTitle, enteredAmount, _selectedDate);
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
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null ? "No Date Chosen!" : DateFormat.yMMMd().format(_selectedDate),
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _presentDatePicker(context);
                      },
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text("Add Transaction"),
                onPressed: (){
                  _submitData();
                },
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        )
    );
  }
}






















