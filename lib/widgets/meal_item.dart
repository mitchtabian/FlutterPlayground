import 'package:firstflutterapp/models/meal.dart';
import 'package:flutter/material.dart';

import '../navigation.dart';
import '../styles.dart';

class MealItem extends StatelessWidget {

  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.removeItem
  });

  String get _complexityText{
    switch(complexity){

      case Complexity.Simple:{
        return "Simple";
      }
      case Complexity.Challenging:{
        return "Challenging";
      }
      case Complexity.Hard:{
        return "Hard";
      }
      default:{
        return "Unknown complexity";
      }
    }
  }

  String get _getAffordabilityText{
    switch(affordability){

      case Affordability.Affordable:{
        return "Affordable";
      }
      case Affordability.Pricey:{
        return "Pricey";
      }
      case Affordability.Luxurious:{
        return "Expensive";
      }
      default:{
        return "Unknown affordability";
      }
    }
  }

  _selectMeal(BuildContext context){
    Navigator.pushNamed(
      context,
      NAV_MEAL_DETAIL_SCREEN,
      arguments: {
        ARG_MEAL_ID: id,
      },
    ).then((result) {
      // executed when popped off
      // Navigator.of(context).pop(_mealId);
      removeItem(result); // access mealId if 'delete' fab is pressed
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectMeal(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RoundedCardRadius),
        ),
        elevation: DefaultCardElevation,
        margin: EdgeInsets.all(DefaultCardMargin),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(RoundedCardRadius),
                    topRight: Radius.circular(RoundedCardRadius),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(DefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule,),
                      SizedBox(width: 3,),
                      Text("$duration min")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work,),
                      SizedBox(width: 3,),
                      Text("$_complexityText")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money,),
                      Text("$_getAffordabilityText")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



