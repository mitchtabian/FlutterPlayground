import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {

  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {

    final id = ModalRoute.of(context).settings.arguments as String;
    final productsData = Provider.of<ProductsProvider>(context, listen: false);
    final loadedProduct = productsData.findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
