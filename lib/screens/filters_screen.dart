import 'package:firstflutterapp/styles.dart';
import 'package:firstflutterapp/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {

  final Function _saveFilters;
  final Map<String, bool> _currentFilters;

  FiltersScreen(this._currentFilters, this._saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget._currentFilters['gluten'];
    _vegetarian = widget._currentFilters['vegetarian'];
    _vegan = widget._currentFilters['vegan'];
    _lactoseFree = widget._currentFilters['lactose'];
    super.initState();
  }

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                "gluten": _glutenFree,
                "lactose": _lactoseFree,
                "vegan": _vegan,
                "vegetarian": _vegetarian,
              };
              widget._saveFilters(selectedFilters);
            },
          )
        ],
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















