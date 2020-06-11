import 'package:firstflutterapp/widgets/new_transaction.dart';
import 'package:firstflutterapp/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                ),
            ),
          )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
//    Transaction(
//        id: "t1",
//        title: "New Shoes",
//        amount: 69.99,
//        date: DateTime.now()
//    ),
//    Transaction(
//        id: "t2",
//        title: "Weekly Groceries",
//        amount: 16.53,
//        date: DateTime.now()
//    ),
  ];


  void _addNewTransaction(String newTitle, double newAmount){
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: DateTime.now()
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(_addNewTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Personal Expenses",),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: double.infinity,
                  child: Card(
                    color: Colors.blue,
                    child: Text("Transactions"),
                    elevation: DefaultCardElevation,
                  ),
                ),
              TransactionList(_userTransactions)
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}























































