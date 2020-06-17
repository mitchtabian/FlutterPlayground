import 'package:firstflutterapp/styles.dart';
import 'package:flutter/material.dart';

import '../navigation.dart';


class CategoryItem extends StatelessWidget {

  final String _id;
  final String _title;
  final Color _color;

  CategoryItem(this._id, this._title, this._color);

  _selectCategory(BuildContext context, ){
    Navigator.pushNamed(
      context,
      NAV_CATEGORY_MEALS_SCREEN,
      arguments: {
        ARG_CATEGORY_ID: _id,
        ARG_CATEGORY_TITLE: _title
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectCategory(context);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(DefaultPadding),
      child: Container(
        padding: const EdgeInsets.all(DefaultPadding),
        child: Text(
          _title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _color.withOpacity(0.7),
              _color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}





