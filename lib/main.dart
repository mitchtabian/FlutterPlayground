import 'file:///D:/Flutter%20Projects/first_flutter_app/lib/screens/category_meals_screen.dart';
import 'package:firstflutterapp/models/dummy_data.dart';
import 'package:firstflutterapp/screens/filters_screen.dart';
import 'package:firstflutterapp/screens/meal_detail_screen.dart';
import 'package:firstflutterapp/screens/not_found_screen.dart';
import 'package:firstflutterapp/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

import 'models/meal.dart';
import 'screens/categories_screen.dart';
import 'navigation.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  _saveFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters["gluten"] && !meal.isGlutenFree){
          return false;
        }
        if(_filters["lactose"] && !meal.isLactoseFree){
          return false;
        }
        if(_filters["vegan"] && !meal.isVegan){
          return false;
        }
        if(_filters["vegetarian"] && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) {
      return meal.id == mealId;
    });
    setState(() {
      if(existingIndex > -1){
        _favoriteMeals.removeAt(existingIndex);
      }
      else{
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    });
  }

  bool _isMealFavorite(String mealId){
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DeliMeals",
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          errorColor: Colors.red,
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 21,
              fontWeight: FontWeight.bold
            ),
            bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1)
            ),
            bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1)
            ),
            button: TextStyle(
              color: Colors.white
            )
          ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                ),
            ),
          )
      ),
      initialRoute: NAV_TABS_SCREEN,
      routes: {
        NAV_TABS_SCREEN: (ctx) => TabsScreen(_favoriteMeals),
        NAV_CATEGORIES_SCREEN: (ctx) => CategoriesScreen(),
        NAV_CATEGORY_MEALS_SCREEN: (ctx) => CategoryMealsScreen(_availableMeals),
        NAV_MEAL_DETAIL_SCREEN: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        NAV_FILTERS_SCREEN: (ctx) => FiltersScreen(_filters, _saveFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => NotFoundScreen()
        );
      },
    );
  }
}
























































