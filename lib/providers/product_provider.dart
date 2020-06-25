import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {

  Product _product;

  String _authToken;

  String _userId;

  ProductProvider(this._product);

  Product get product{
    return _product;
  }

  _setFavValue(bool newValue){
    _product.isFavorite = newValue;
    notifyListeners();
  }

  setUserId(String userId){
    _userId = userId;
    notifyListeners();
  }

  setAuthToken(String token){
    _authToken = token;
    notifyListeners();
  }

  String _buildUrl({String node, String userId, String productId}){
    String url = "https://flutter-shopping-app-248d6.firebaseio.com/$node";
    if(userId != null){
      url = url + "/$userId";
    }
    if(productId != null){
      url = url + "/$productId";
    }
    url = url + ".json?auth=$_authToken";
    return url;
  }


  Future<void> toggleFavoriteStatus() async {
    final oldStatus = product.isFavorite;
    _product.isFavorite = !_product.isFavorite;
    notifyListeners();
    final productUrl = _buildUrl(
        node:"user_favorites",
        userId: _userId,
        productId:product.id
    );
    try{
      final response = await http.put(
          productUrl,
          body: json.encode(
            _product.isFavorite
          )
      );
      if(response.statusCode >= 400){
        _setFavValue(oldStatus);
      }
    }catch(error){
      _setFavValue(oldStatus);
    }
  }

}











