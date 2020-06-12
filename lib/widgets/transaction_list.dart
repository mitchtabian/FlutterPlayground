import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;

  TransactionList(this._userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
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
          return Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                      "\$${_userTransactions[index].amount.toStringAsFixed(2)}"
                    ),
                  ),
                ),
              ),
              title: Text(
                _userTransactions[index].title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(_userTransactions[index].date),
              ),
              trailing: mediaQuery.size.width > 460
                  ? FlatButton.icon(
                  onPressed: () {},
                  textColor: Theme.of(context).errorColor,
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
              )
                  : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  _deleteTransaction(_userTransactions[index].id);
                },
              ),
            ),
          );
        },
        itemCount: _userTransactions.length,
      ),
    );
  }
}


























