import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';
import 'providers/products_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'screens/cart_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/user_products_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context){
            return AuthProvider();
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (BuildContext ctx) {
            return ProductsProvider();
          },
          update: (BuildContext ctx, auth, previous) {
            previous.setAuthToken(auth.token);
            return previous;
          },
        ),
        ChangeNotifierProvider(
          create: (context){
            return CartProvider();
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
          create: (BuildContext ctx) {
            return OrderProvider();
          },
          update: (BuildContext ctx, auth, previous) {
            previous.setAuthToken(auth.token);
            return previous;
          },
        ),
      ],
        child: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => MaterialApp(
            title: "MyShop",
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: "Lato",
            ),
            home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              AuthScreen.routeName: (ctx) => AuthScreen(),
              ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          )
        )
    );
  }
}



























































