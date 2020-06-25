
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';
import 'product_provider.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {

  String _authToken;

  String _userId;

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

  setAuthToken(String token){
    _authToken = token;
    notifyListeners();
  }

  setUserId(String userId){
    _userId = userId;
    notifyListeners();
  }

  String _buildUrl({String node, String userId, String productId, String orderBy}){
    String url = "https://flutter-shopping-app-248d6.firebaseio.com/$node";
    if(userId != null){
      url = url + "/$userId";
    }
    if(productId != null){
      url = url + "/$productId";
    }
    url = url + ".json?auth=$_authToken";
    if(orderBy != null){
      url = url + '&orderBy="$orderBy"&equalTo="$_userId"';
    }
    return url;
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var url = _buildUrl(
        node:"products",
        userId: null,
        productId: null,
        orderBy: filterByUser ? "creatorId" : null
    );
    print(url);
    try{
      var response = await http.get(url,);
      final extractedProductsData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedProductsData == null){
        return;
      }
      url = _buildUrl(node:"user_favorites", userId: _userId, productId: null, orderBy: null);
      response = await http.get(url,);
      final extractedFavoritesData = json.decode(response.body);
      _items.clear();
      extractedProductsData.forEach((productId, product) {
        _items.add(
            ProductProvider(
              Product(
                id: productId,
                title: product["title"],
                description: product["description"],
                imageUrl: product["imageUrl"],
                price: product["price"],
                isFavorite: extractedFavoritesData == null ? false : extractedFavoritesData[productId] ?? false
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
    final url = _buildUrl(node: "products", userId: null, productId: null);
    try{
      final response = await http.post(
          url,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "price": product.price,
            "creatorId": _userId
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
      final url = _buildUrl(node: "products", userId: null, productId: null);
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
    final url = _buildUrl(node: "products",  userId: null, productId: null);
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

















