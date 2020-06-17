import 'package:firstflutterapp/navigation.dart';
import 'package:firstflutterapp/styles.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {

  Widget buildListTile(String title, IconData iconData, Function tapHandler){
    return ListTile(
      leading: Icon(iconData),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "OpenSans",
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(DefaultPadding),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: Theme.of(context).primaryColor
              ),
            ),
          ),
          SizedBox(height: 20,),
          buildListTile("Meals", Icons.restaurant, (){
            Navigator.of(context).pushReplacementNamed(NAV_TABS_SCREEN);
          }),
          buildListTile("Filters", Icons.settings, (){
            Navigator.of(context).pushReplacementNamed(NAV_FILTERS_SCREEN);
          }),
        ],
      ),
    );
  }
}














