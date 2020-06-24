import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductProvider extends Product with ChangeNotifier {

  Product _product;

  ProductProvider(this._product);

  Product get product{
    return _product;
  }

  toggleFavoriteStatus(){
    _product.isFavorite = !_product.isFavorite;
    notifyListeners();
  }

}











