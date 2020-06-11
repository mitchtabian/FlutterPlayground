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
      child: _userTransactions.isEmpty ? Column(
        children: <Widget>[
          Text(
            "No transactions added yet!",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20,),
          Container(
            child: Image.asset(
              "assets/images/waiting.png",
              fit: BoxFit.cover,
            ),
            height: 200,
          ),
        ]
      ) : ListView.builder(
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
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                      vertical: vCardMargin,
                      horizontal: hCardMargin
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
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
                        style: Theme.of(context).textTheme.headline6,
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


























