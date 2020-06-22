import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:firstflutterapp/models/order_item.dart';

class OrderListItem extends StatefulWidget {

  final OrderItem order;

  OrderListItem(this.order);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {

  var _expanded = false;

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "\$${widget.order.amount}"
            ),
            subtitle: Text(
                "${DateFormat.yMMMEd().format(widget.order.dateTime)} at ${DateFormat.Hm().format(widget.order.dateTime)}"
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if(_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 10, 100),
              child: ListView(
                children: <Widget>[
                  ...widget.order.products.map((product) => Row(
                    children: <Widget>[
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                          "${product.quantity} x \$${product.price}",
                          style: TextStyle(
                              fontSize: 18,
                          )
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  )).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}














