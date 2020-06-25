import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../screens/product_detail_screen.dart';
import '../styles.dart';

class ProductGridItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final product = productProvider.product;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return MultiProvider(
      providers: [
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          create: (BuildContext ctx) {
            return ProductProvider(product);
          },
          update: (BuildContext ctx, auth, previous) {
            previous.setAuthToken(auth.token);
            return previous;
          },
        ),
        ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RoundedRectRadius),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName,
                  arguments: product.id
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<ProductProvider>(
              builder: (ctx, productProvider, _) {
                return IconButton(
                  icon: Icon(productProvider.product.isFavorite ? Icons.favorite: Icons.favorite_border),
                  onPressed: () {
                    productProvider.toggleFavoriteStatus();
                  },
                  color: Theme.of(context).accentColor,
                );
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cartProvider.addItem(product.id, product.price, product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Added item to cart!"),
                      duration: Duration(
                        seconds: 2
                      ),
                      action: SnackBarAction(
                        onPressed: () {
                          cartProvider.removeSingleItem(product.id);
                        },
                        label: "Undo",
                      ),
                    ),
                );
              },
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}














