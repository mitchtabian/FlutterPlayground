
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';
import 'product_provider.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {

  List<ProductProvider> _items = [];

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

  Future<void> fetchAndSetProducts() async {
    const url = "https://flutter-shopping-app-248d6.firebaseio.com/products.json";
    try{
      final response = await http.get(url,);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      _items.clear();
      if(extractedData == null){
        return;
      }
      extractedData.forEach((productId, product) {
        _items.add(
            ProductProvider(
              Product(
                id: productId,
                title: product["title"],
                description: product["description"],
                imageUrl: product["imageUrl"],
                price: product["price"],
                isFavorite: product["isFavorite"]
              )
            )
        );
      });
      notifyListeners();
    }catch(error){
      throw error;
    }
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
            "isFavorite": product.isFavorite
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

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((productProvider) => productProvider.product.id == id);
    if(productIndex >= 0){
      final url = "https://flutter-shopping-app-248d6.firebaseio.com/products/${id}.json";
      await http.patch(
        url,
        body: json.encode({
          "title": newProduct.title,
          "description": newProduct.description,
          "price": newProduct.price,
          "imageUrl": newProduct.imageUrl,
        })
      );
      _items[productIndex] = ProductProvider(newProduct);
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = "https://flutter-shopping-app-248d6.firebaseio.com/products/${id}.json";
    var existingProductIndex = _items.indexWhere((productProvider) => productProvider.product.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeWhere((productProvider) => productProvider.product.id == id);
    notifyListeners();
    var response = await http.delete(url);
    if(response.statusCode >= 400){
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException("Could not delete product from server.");
    }
    existingProductIndex = null;
    existingProduct = null;
  }
}

















