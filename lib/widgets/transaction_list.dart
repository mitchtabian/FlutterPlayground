import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styles.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> _userTransactions;

  TransactionList(this._userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "\$${_userTransactions[index].amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediumTextSize,
                      color: Colors.purple,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                      vertical: vCardMargin,
                      horizontal: hCardMargin
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: DefaultBorderWidth,
                      )
                  ),
                  padding: EdgeInsets.all(DefaultCardPadding),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "${_userTransactions[index].title.toString()}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: MediumTextSize,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        DateFormat.yMMMd().format(_userTransactions[index].date),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: SmallTextSize,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: _userTransactions.length,
      ),
    );
  }
}


























