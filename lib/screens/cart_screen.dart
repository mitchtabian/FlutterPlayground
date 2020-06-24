
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../widgets/cart_list_item.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../styles.dart';


class CartScreen extends StatelessWidget {

  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final ordersProvider = Provider.of<OrderProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Cart"
        ),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(DefaultMargin),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cartProvider.getTotalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headline6.color
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cartProvider: cartProvider, ordersProvider: ordersProvider),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: (ctx, index) => CartListItem(
                    cartProvider.items.values.toList()[index].id,
                    cartProvider.items.keys.toList()[index],
                    cartProvider.items.values.toList()[index].price,
                    cartProvider.items.values.toList()[index].quantity,
                    cartProvider.items.values.toList()[index].title,
                  ),
                  itemCount: cartProvider.getItemCount,
                ),
              )
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartProvider,
    @required this.ordersProvider,
  }) : super(key: key);

  final CartProvider cartProvider;
  final OrderProvider ordersProvider;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text("ORDER NOW"),
      onPressed: (widget.cartProvider.getTotalAmount <= 0) || _isLoading ? null : () async {
        setState(() {
          _isLoading = true;
        });
        await widget.ordersProvider.addOrder(
            widget.cartProvider.items.values.toList(),
            widget.cartProvider.getTotalAmount
        );
        setState(() {
          _isLoading = false;
        });
        widget.cartProvider.clear();
      },
      textColor: Theme.of(context).primaryColor,
    );
  }
}






