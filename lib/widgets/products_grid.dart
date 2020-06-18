import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../styles.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool _showOnlyFavoritesData;

  ProductsGrid(this._showOnlyFavoritesData);

  @override
  Widget build(BuildContext context) {

    final _productsData = Provider.of<ProductsProvider>(context, listen: true);
    final _products = _showOnlyFavoritesData ? _productsData.favoriteItems: _productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(DefaultPadding),
      itemCount: _products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: _products[i],
        child: ProductItem(),
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
















