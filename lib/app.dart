import 'package:flutter/material.dart';

import 'screens/location_detail/location_detail.dart';
import 'style.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationDetail(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: AppBarTextStyle,
          ),
        ),
        textTheme: TextTheme(
          headline6: TitleTextStyle,
          bodyText1: Body1TextStyle
        ),
      ),
    );
  }
}
