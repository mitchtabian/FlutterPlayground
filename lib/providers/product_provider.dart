import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {

  Product _product;

  ProductProvider(this._product);

  Product get product{
    return _product;
  }

  _setFavValue(bool newValue){
    _product.isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = product.isFavorite;
    _product.isFavorite = !_product.isFavorite;
    notifyListeners();
    final url = "https://flutter-shopping-app-248d6.firebaseio.com/products/${product.id}.json";
    try{
      final response = await http.patch(
          url,
          body: json.encode({
            "isFavorite":_product.isFavorite
          })
      );
      if(response.statusCode >= 400){
        _setFavValue(oldStatus);
      }
    }catch(error){
      _setFavValue(oldStatus);
    }

  }

}











