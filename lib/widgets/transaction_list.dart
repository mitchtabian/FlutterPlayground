import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:firstflutterapp/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;

  TransactionList(this._userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    print("build() TransactionList");
    final mediaQuery = MediaQuery.of(context);
    return Container(
      alignment: Alignment.center,
      child: _userTransactions.isEmpty ? LayoutBuilder( builder: (ctx, constraints){
        return Column(
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
                height: constraints.maxHeight * 0.6,
              ),
            ]
        );
      },
      ) : ListView.builder(
        itemBuilder: (ctx, index) {
          return TransactionItem(
              key: ValueKey(_userTransactions[index].id),
              transaction: _userTransactions[index],
              mediaQuery: mediaQuery,
              deleteTransaction: _deleteTransaction
          );
        },
        itemCount: _userTransactions.length,
      ),
    );
  }
}




























