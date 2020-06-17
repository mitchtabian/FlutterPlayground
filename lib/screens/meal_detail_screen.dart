import 'package:firstflutterapp/models/dummy_data.dart';
import 'package:firstflutterapp/navigation.dart';
import 'package:firstflutterapp/styles.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {

  final Function _toggleFavorite;
  final Function _isFavorite;

  MealDetailScreen(this._toggleFavorite, this._isFavorite);

  @override
  Widget build(BuildContext context) {

    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String _mealId = routeArgs[ARG_MEAL_ID];
    final _meal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id.contains(_mealId);
    });

    Widget buildSectionTitle(BuildContext context, String title){
      return Container(
        margin: EdgeInsets.symmetric(
            horizontal: DefaultMargin
        ),
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      );
    }

    Widget buildSectionContainer(BuildContext context, Widget child){
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: DefaultMargin
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.grey
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 200,
        width: double.infinity,
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FittedBox(
              child: Image.network(_meal.imageUrl),
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10,),
            buildSectionTitle(context, "Ingredients"),
            SizedBox(height: 5,),
            buildSectionContainer(
                context,
                ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10
                      ),
                      child: Text(_meal.ingredients[index]),
                    ),
                  ),
                  itemCount: _meal.ingredients.length,
                )
            ),
            SizedBox(height: DefaultMargin,),
            buildSectionTitle(context, "Steps"),
            SizedBox(height: 5,),
            buildSectionContainer(
                context,
                ListView.builder(
                  itemBuilder: (ctx, index) =>
                      Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              child: Text("# ${index + 1}"),
                            ),
                            title: Text(_meal.steps[index]),
                          ),
                          Divider(

                          ),
                        ],
                      ),
                  itemCount: _meal.steps.length,
                )
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: _isFavorite(_mealId) ? Icon(Icons.star) : Icon(Icons.star_border),
        onPressed: (){
          _toggleFavorite(_mealId);
        },
      ),
    );
  }
}



