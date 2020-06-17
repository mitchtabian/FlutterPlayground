import 'package:firstflutterapp/models/meal.dart';
import 'package:firstflutterapp/screens/categories_screen.dart';
import 'package:firstflutterapp/screens/favorites_screen.dart';
import 'package:firstflutterapp/widgets/main_drawer.dart';
import 'package:flutter/material.dart';


class TabsScreen extends StatefulWidget {

  final List<Meal> _favoriteMeals;

  TabsScreen(this._favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        "page": CategoriesScreen(),
        "title": "Categories"
      },
      {
        "page": FavoritesScreen(widget._favoriteMeals),
        "title": "Favorites"
      }
    ];
    super.initState();
  }

  _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]["title"],),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedPageIndex]["page"],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text("Categories"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.favorite),
              title: Text("Favorites"),
            ),
          ]
        ),
    );
  }
}









