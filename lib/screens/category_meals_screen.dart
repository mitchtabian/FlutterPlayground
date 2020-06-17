import 'package:firstflutterapp/models/dummy_data.dart';
import 'package:firstflutterapp/widgets/meal_item.dart';
import 'package:flutter/material.dart';

import '../navigation.dart';

class CategoryMealsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String _categoryId = routeArgs[ARG_CATEGORY_ID];
    final String _categoryTitle = routeArgs[ARG_CATEGORY_TITLE];
    final _categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(_categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _categoryMeals[index].id,
            title: _categoryMeals[index].title,
            imageUrl: _categoryMeals[index].imageUrl,
            duration: _categoryMeals[index].duration,
            complexity: _categoryMeals[index].complexity,
            affordability: _categoryMeals[index].affordability,
          );},
        itemCount: _categoryMeals.length,
      ),
    );
  }
}










