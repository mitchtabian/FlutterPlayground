import 'package:firstflutterapp/styles.dart';
import 'package:firstflutterapp/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  Widget buildSwitchListTile(
      bool bool,
      String title,
      String subTitle,
      Function updateBool
      ){
    return SwitchListTile(
      onChanged: updateBool,
      value: bool,
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your filters"),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(DefaultPadding),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildSwitchListTile(
                    _glutenFree,
                    "Gluten-free",
                    "Only include Gluten-free meals.",
                    (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    }
                ),
                buildSwitchListTile(
                    _vegetarian,
                    "Vegetarian",
                    "Only include Vegetarian meals.",
                        (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    }
                ),
                buildSwitchListTile(
                    _vegan,
                    "Vegan",
                    "Only include Vegan meals.",
                        (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    }
                ),
                buildSwitchListTile(
                    _lactoseFree,
                    "Lactose-free",
                    "Only include Lactose-free meals.",
                        (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}















