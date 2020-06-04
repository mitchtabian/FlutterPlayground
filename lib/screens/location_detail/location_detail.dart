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
        ]..addAll(textSections(location))
      ),
    );
  }

  List<Widget> textSections(Location location){
    return location.facts
        .map((fact) {
          return TextSection(fact.title, fact.text);
    }).toList();
  }
}




















