import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/cart_item.dart';
import '../models/order_item.dart';

class OrderProvider with ChangeNotifier {

  List<OrderItem> _orders = [];

  List<OrderItem> get getOrders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = "https://flutter-shopping-app-248d6.firebaseio.com/orders.json";
    try{
      final dateTime = DateTime.now();
      final response = await http.post(
          url,
          body: json.encode({
            "amount": total,
            "dateTime": dateTime.toIso8601String(),
            "products": [
              cartProducts.map((cartItem) {
                return {
                  "id": cartItem.id,
                  "title": cartItem.title,
                  "quantity": cartItem.quantity,
                  "price": cartItem.price
                };
              }).toList(),
            ],
          })
      );
      final newOrder = OrderItem(
          id: json.decode(response.body)["name"],
          amount: total,
          dateTime: dateTime,
          products: cartProducts
      );
      _orders.insert(0, newOrder);
      notifyListeners();
    } catch(error){
      throw error;
    }
  }
}























