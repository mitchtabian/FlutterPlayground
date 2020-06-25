import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {

  Product _product;

  String _authToken;

  ProductProvider(this._product);

  Product get product{
    return _product;
  }

  _setFavValue(bool newValue){
    _product.isFavorite = newValue;
    notifyListeners();
  }

  setAuthToken(String token){
    _authToken = token;
    notifyListeners();
  }

  String _buildUrl(String node, String id){
    String url = "https://flutter-shopping-app-248d6.firebaseio.com/$node";
    if(id != null){
      url = url + "/$id";
    }
    url = url + ".json?auth=$_authToken";
    return url;
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = product.isFavorite;
    _product.isFavorite = !_product.isFavorite;
    notifyListeners();
    final url = _buildUrl("products", product.id);
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











