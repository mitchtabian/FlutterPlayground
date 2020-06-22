import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_list_item.dart';
import '../providers/order_provider.dart';

class OrdersScreen extends StatelessWidget {

  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {

    final orderProvider = Provider.of<OrderProvider>(context);
    print(orderProvider.getOrders);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) => OrderListItem(orderProvider.getOrders[index]),
        itemCount: orderProvider.getOrders.length,
      ),
    );
  }
}
















