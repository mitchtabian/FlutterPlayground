import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'product_provider.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {

  List<ProductProvider> _items = [
    ProductProvider(
      Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      )
    ),
    ProductProvider(
      Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      )
    ),
    ProductProvider(
      Product(
        id: 'p3',
        title: 'Yellow Scarf',
        description: 'Warm and cozy - exactly what you need for the winter.',
        price: 19.99,
        imageUrl:
        'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      )
    ),
    ProductProvider(
      Product(
        id: 'p4',
        title: 'A Pan',
        description: 'Prepare any meal you want.',
        price: 49.99,
        imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      )
    ),
  ];

  List<ProductProvider> get favoriteItems{
    return _items.where((element) => element.product.isFavorite).toList();
  }

  List<ProductProvider> get items {
    return [..._items]; // copy and return the items
  }

  ProductProvider findById(String id){
    return _items
        .firstWhere((provider) => provider.product.id == id);
  }

  Future<void> addProduct(Product product) async {
    const url = "https://flutter-shopping-app-248d6.firebaseio.com/products.json";
    try{
      final response = await http.post(
          url,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "price": product.price,
            "favorite": product.isFavorite
          })
      );
      final newProduct = Product(
          id: json.decode(response.body)["name"],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl
      );
      _items.add(
          ProductProvider(newProduct)
      );
      notifyListeners();
    } catch(error){
      throw error;
    }
  }

  updateProduct(String id, Product newProduct){
    final productIndex = _items.indexWhere((productProvider) => productProvider.product.id == id);
    if(productIndex >= 0){
      _items[productIndex] = ProductProvider(newProduct);
      notifyListeners();
    }
  }

  deleteProduct(String id){
    _items.removeWhere((productProvider) => productProvider.product.id == id);
    notifyListeners();
  }
}

















