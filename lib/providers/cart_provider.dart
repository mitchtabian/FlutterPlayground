import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';

class CartProvider with ChangeNotifier{

  Map<String, CartItem> _items;

  Map<String, CartItem> get items{
    return {..._items};
  }

  addItem(String productId, double price, String title){
    if(_items.containsKey(productId)){
      _items.update(productId, (existingCartItem) {
        return CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        );
      });
    }
    else{
      _items.putIfAbsent(productId, () {
        return CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          quantity: 1,
        );
      });
    }
  }

}