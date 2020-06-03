import 'package:flutter/material.dart';

import 'text_section.dart';
import 'image_banner.dart';
import 'package:firstflutterapp/models/location.dart';

class LocationDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locations = Location.fetchAll();
    final location = locations.first;
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ImageBanner(location.imagePath),
          TextSection("Summary1", "something 1 hfgh gfh gfhfghfghfg hfg"),
          TextSection("Summary2", "something 2gf hfgh fghfg hgfh fghfg hfgh fghfghfgh"),
          TextSection("Summary3 ", "something 3 hgfh fghgf hrtjrtjrtj tjrt j"),
        ],
      ),
    );
  }
}




















