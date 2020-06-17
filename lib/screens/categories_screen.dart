import 'file:///D:/Flutter%20Projects/first_flutter_app/lib/widgets/category_item.dart';
import 'package:firstflutterapp/styles.dart';
import 'package:flutter/material.dart';

import '../models/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(DefaultGridPadding),
      children: <Widget>[
        ...DUMMY_CATEGORIES.map(
                (catData) => CategoryItem(
                catData.id,
                catData.title,
                catData.color
            )
        ).toList()
      ],
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2, // 300 height, 200 width,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
      ),
    );
  }
}





















