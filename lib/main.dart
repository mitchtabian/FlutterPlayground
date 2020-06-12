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

  Widget _buildTxListContent(MediaQueryData mediaQuery, AppBar appBar){
    return Container(
        height: (mediaQuery.size.height
            - appBar.preferredSize.height
            - mediaQuery.padding.top) * 0.7,
        child: TransactionList(_userTransactions, _deleteTransaction)
    );
  }

  Widget _buildChartContent(MediaQueryData mediaQuery, AppBar appBar, double heightPct){
    return Container(
        height: (mediaQuery.size.height
            - appBar.preferredSize.height
            - mediaQuery.padding.top) * heightPct,
        child: Chart(_recentTransactions)
    );
  }

  Widget _buildLandscapeContent(MediaQueryData mediaQuery, AppBar appBar){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Show Chart"),
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
        _showChart
            ?  _buildChartContent(mediaQuery, appBar, 0.7)
            : _buildTxListContent(mediaQuery, appBar)
      ],
    );
  }

  Widget _buildPortraitContent(MediaQueryData mediaQuery, AppBar appBar){

    return Column(
      children: <Widget>[
        _buildChartContent(mediaQuery, appBar, 0.3),
        _buildTxListContent(mediaQuery, appBar)
      ],
    );
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

    final pageBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if(isLandscape) _buildLandscapeContent(mediaQuery, appBar),
          if (!isLandscape) _buildPortraitContent(mediaQuery, appBar),
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























































