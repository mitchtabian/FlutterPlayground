import 'package:flutter/material.dart';

import 'package:firstflutterapp/widgets/chart_bar.dart';
import 'package:firstflutterapp/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions){
    print("Constructor Chart");
  }

  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      double totalSum = 0.0;
      for(var i = 0; i < _recentTransactions.length - 1; i++){
        if(_recentTransactions[i].date.day == weekDay.day
          && _recentTransactions[i].date.month == weekDay.month
          && _recentTransactions[i].date.year == weekDay.year){
          totalSum += _recentTransactions[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 3),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (previousValue, listElement) {
      return previousValue + listElement["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build() Chart");
    return totalSpending == 0.0 ? SizedBox(height: 10) : Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data["day"],
                  data["amount"],
                  ((data["amount"] as double) / totalSpending)
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}





















