import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';
import 'package:firstflutterapp/widgets/chart.dart';
import 'package:firstflutterapp/widgets/new_transaction.dart';
import 'package:firstflutterapp/widgets/transaction_list.dart';
import 'styles.dart';

void main() {
  // set portrait only
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
//  );
  runApp(MyApp());
}

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
          errorColor: Colors.red,
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              color: Colors.white
            )
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

  final List<Transaction> _userTransactions = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addNewTransaction(String newTitle, double newAmount, DateTime chosenDate){
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: chosenDate
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

  _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build() MyHomePageState");
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text("Personal Expenses",),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    final txListWidget = Container(
        height: (mediaQuery.size.height
            - appBar.preferredSize.height
            - mediaQuery.padding.top) * 0.7,
        child: TransactionList(_userTransactions, _deleteTransaction)
    );

    final pageBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if(isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Show Chart"),
              Switch(
                value: _showChart,
                onChanged: (bool) {
                  setState(() {
                    _showChart = bool;
                  });
                },
              ),
            ],
          ),
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height
                    - appBar.preferredSize.height
                    - mediaQuery.padding.top) * 0.3,
                child: Chart(_recentTransactions)
            ),
          if (!isLandscape)
            txListWidget,
          if (isLandscape)
            _showChart ?  Container(
                height: (mediaQuery.size.height
                    - appBar.preferredSize.height
                    - mediaQuery.padding.top) * 0.7,
                child: Chart(_recentTransactions)
            ) : txListWidget
        ],
      ),
    );

    return Scaffold(
        appBar: appBar,
        body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}























































