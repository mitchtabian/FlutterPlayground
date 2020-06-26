import 'package:firstflutterapp/providers/great_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/places_list_screen.dart';
import 'screens/add_place_screen.dart';
import 'screens/place_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) {
        return GreatPlacesProvider();
      },
      child: MaterialApp(
        title: "MyShop",
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          fontFamily: "Lato",
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}





























































