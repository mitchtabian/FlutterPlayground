import 'package:firstflutterapp/models/dummy_data.dart';
import 'package:firstflutterapp/models/meal.dart';
import 'package:firstflutterapp/widgets/meal_item.dart';
import 'package:flutter/material.dart';

import '../navigation.dart';

class CategoryMealsScreen extends StatefulWidget {

  @override
  _displayedMealsScreenState createState() => _displayedMealsScreenState();
}

class _displayedMealsScreenState extends State<CategoryMealsScreen> {

  String _title;
  List<Meal> _displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routeArgs[ARG_CATEGORY_ID];
      _title = routeArgs[ARG_CATEGORY_TITLE];
      _displayedMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    }
    _loadedInitData = true;
    super.didChangeDependencies();
  }

  _removeMeal(String mealId){
    setState(() {
      _displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            removeItem: _removeMeal,
            id: _displayedMeals[index].id,
            title: _displayedMeals[index].title,
            imageUrl: _displayedMeals[index].imageUrl,
            duration: _displayedMeals[index].duration,
            complexity: _displayedMeals[index].complexity,
            affordability: _displayedMeals[index].affordability,
          );},
        itemCount: _displayedMeals.length,
      ),
    );
  }


}










