import 'package:flutter/material.dart';

import '../models/Product.dart';


class ProductsProvider with ChangeNotifier {

  List<Product> _items = [];

  List<Product> get items {
    return [..._items]; // copy and return the items
  }

  addProduct(){
//    _items.add(product);
    notifyListeners();
  }
}