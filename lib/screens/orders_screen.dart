import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order_item.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_list_item.dart';
import '../providers/order_provider.dart';

class OrdersScreen extends StatefulWidget {

  static const routeName = "/orders";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  var _isInit = false;
  var _isLoading = false;

  _setIsLoading(bool isLoading){
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void didChangeDependencies() {
    if(!_isInit){
      _setIsLoading(true);
      Provider.of<OrderProvider>(context, listen: false)
          .fetchAndSetOrders()
          .then((value) {
            _setIsLoading(false);
          });
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    List<OrderItem> _orders = Provider.of<OrderProvider>(context, listen: false).getOrders;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: _isLoading ?
      Center(
        child: CircularProgressIndicator(),
      ) :
      _orders.length <= 0 ?
      Center(
        child: Text("There's no orders"),
      ):
      ListView.builder(
        itemBuilder: (ctx, index) => OrderListItem(_orders[index]),
        itemCount: _orders.length,
      ),
    );
  }


}
















