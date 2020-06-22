import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart';

class OrderProvider with ChangeNotifier {

  List<OrderItem> _orders = [];

  List<OrderItem> get getOrders {
    return [..._orders];
  }

  addOrder(List<CartItem> cartProducts, double total){
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          dateTime: DateTime.now(),
          products: cartProducts
        )
    );
    notifyListeners();
  }
}
