import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_list_item.dart';
import '../providers/products_provider.dart';

class UserProductsScreen extends StatelessWidget {

  static const routeName = "/user-products";

  @override
  Widget build(BuildContext context) {

    final productsData = Provider.of<ProductsProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, index) => Column(
            children: <Widget>[
              UserProductListItem(
                  productsData.items[index].product.id,
                  productsData.items[index].product.title,
                  productsData.items[index].product.imageUrl
              ),
              Divider(),
            ],
          ),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}












