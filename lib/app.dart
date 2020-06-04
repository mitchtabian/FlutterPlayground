import 'package:flutter/material.dart';

import 'screens/location_detail/location_detail.dart';
import 'package:firstflutterapp/screens/locations/locations.dart';
import 'style.dart';

const LocationRoute = "/";
const LocationDetailRoute = "/location_detail";

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
      theme: _theme(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch(settings.name){
        case LocationRoute:
          screen = Locations();
          break;

        case LocationDetailRoute:
          screen = LocationDetail(arguments["id"]);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline6: AppBarTextStyle,
        ),
      ),
      textTheme: TextTheme(
          headline6: TitleTextStyle,
          bodyText1: Body1TextStyle
      ),
    );
  }
}


















