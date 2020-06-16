import 'file:///D:/Flutter%20Projects/first_flutter_app/lib/screens/category_meals_screen.dart';
import 'package:flutter/material.dart';

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
      initialRoute: "/",
      routes: {
        NAV_CATEGORIES_SCREEN: (ctx) => CategoriesScreen(),
        NAV_CATEGORY_MEALS_SCREEN: (ctx) => CategoryMealsScreen(),
      },
    );
  }
}
























































