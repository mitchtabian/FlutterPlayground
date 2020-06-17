import 'package:firstflutterapp/screens/categories_screen.dart';
import 'package:firstflutterapp/screens/favorites_screen.dart';
import 'package:flutter/material.dart';


class TabsScreen extends StatefulWidget {

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  static const NUM_TABS = 2;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: NUM_TABS,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meals"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: "Categories",
              ),
              Tab(
                icon: Icon(Icons.star),
                text: "Favorites",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CategoriesScreen(),
            FavoritesScreen()
          ],
        ),
      ),
    );
  }
}









