import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';
import 'providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context){
        return ProductsProvider();
      },
      child: MaterialApp(
        title: "MyShop",
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: "Lato",
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}



























































