import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../styles.dart';
import '../providers/cart_provider.dart';

class CartListItem extends StatelessWidget {

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartListItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartProvider.removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to remove the item from the cart?"),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: (){
                  Navigator.of(ctx).pop(true);
                },
              )
            ],
          )
        );
      },
      background: Container(
        margin: EdgeInsets.symmetric(
            horizontal: DefaultMargin,
            vertical: 4
        ),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: DefaultMargin,
            vertical: 4
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                      "\$$price"
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text(
              "Total: \$${price * quantity}",
            ),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}


















