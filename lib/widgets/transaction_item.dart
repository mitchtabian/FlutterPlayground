import 'dart:math';

import 'package:flutter/material.dart';

import 'package:firstflutterapp/models/transaction.dart';
import 'package:intl/intl.dart';


class TransactionItem extends StatefulWidget {

  const TransactionItem({
    Key key,
    @required Transaction transaction,
    @required this.mediaQuery,
    @required Function deleteTransaction,
  }) : _transaction = transaction, _deleteTransaction = deleteTransaction, super(key: key);

  final Transaction _transaction;
  final MediaQueryData mediaQuery;
  final Function _deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color _bgColor;

  @override
  void initState() {
    const availableColors = [Colors.red, Colors.black, Colors.blue, Colors.purple];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                  "\$${widget._transaction.amount.toStringAsFixed(2)}"
              ),
            ),
          ),
        ),
        title: Text(
          widget._transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget._transaction.date),
        ),
        trailing: widget.mediaQuery.size.width > 460
            ? FlatButton.icon(
          onPressed: () {
            widget._deleteTransaction(widget._transaction.id);
          },
          textColor: Theme.of(context).errorColor,
          icon: const Icon(Icons.delete),
          label: const Text("Delete"),
        )
            : IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            widget._deleteTransaction(widget._transaction.id);
          },
        ),
      ),
    );
  }


}














