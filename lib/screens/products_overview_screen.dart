import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/badge.dart';
import '../screens/cart_screen.dart';
import '../widgets/products_grid.dart';
import '../widgets/app_drawer.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

enum FilterOptions {
  Favorites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  var _showOnlyFavoritesData = false;
  var _isInit = false;
  var _isLoading = false;


  @override
  void didChangeDependencies() {
    if(!_isInit){
      _setIsLoading(true);
      Provider.of<ProductsProvider>(context)
          .fetchAndSetProducts()
          .then((value){
            _setIsLoading(false);
          });
      _isInit = true;
    }

    super.didChangeDependencies();
  }

  _setIsLoading(bool isLoading){
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if(selectedValue == FilterOptions.Favorites){
                  _showOnlyFavoritesData = true;
                }
                else{
                  _showOnlyFavoritesData = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Text("Only Favorites"),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text("Show All"),
                  value: FilterOptions.All,
                ),
              ];
            },
          ),
          Consumer<CartProvider>(
            builder: (_, cartProvider, ch) => Badge(
              child: ch,
              value: cartProvider.getItemCount.toString(),
              color: Theme.of(context).accentColor,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading?
      Center(
        child: CircularProgressIndicator(),
      ):
      ProductsGrid(_showOnlyFavoritesData),
    );
  }
}



















