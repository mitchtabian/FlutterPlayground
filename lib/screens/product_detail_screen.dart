import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {

  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {

    final id = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("_title"),
      ),
    );
  }
}
