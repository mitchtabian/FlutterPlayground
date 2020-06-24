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
            "products": cartProducts.map((cartItem) {
              return {
                "id": cartItem.id,
                "title": cartItem.title,
                "quantity": cartItem.quantity,
                "price": cartItem.price
              };
            }).toList(),
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

  Future<void> fetchAndSetOrders() async {
    const url = "https://flutter-shopping-app-248d6.firebaseio.com/orders.json";
    try{
      final response = await http.get(url,);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      _orders.clear();
      if(extractedData == null){
        return;
      }
      extractedData.forEach((orderId, orderItem) {
        _orders.add(
            OrderItem(
                id: orderId,
                amount: orderItem["amount"],
                dateTime: DateTime.parse(orderItem["dateTime"]),
                products: (orderItem["products"] as List<dynamic>).map((item) {
                  return CartItem(
                    id: item["id"],
                    price: item["price"],
                    quantity: item["quantity"],
                    title: item["title"],
                  );
                }).toList()
            )
        );
      });
      _orders = _orders.reversed.toList();
      notifyListeners();
    }catch(error){
      throw error;
    }
  }
}























