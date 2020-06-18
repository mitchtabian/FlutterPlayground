import 'package:firstflutterapp/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Product.dart';
import '../styles.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _productsData = Provider.of<ProductsProvider>(context);
    final _products = _productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(DefaultPadding),
      itemCount: _products.length,
      itemBuilder: (ctx, i) => ProductItem(
        _products[i].id,
        _products[i].title,
        _products[i].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // num columns
        childAspectRatio: 3 / 2, // height/width
        crossAxisSpacing: DefaultGridCrossAxisSpacing,
        mainAxisSpacing: DefaultGridMainAxisSpacing,
      ),
    );
  }
}