import 'package:flutter/material.dart';

import 'package:firstflutterapp/widgets/text_section.dart';
import 'package:firstflutterapp/widgets/image_banner.dart';
import 'package:firstflutterapp/models/location.dart';

class LocationDetail extends StatelessWidget {

  final int _locationID;

  LocationDetail(this._locationID);

  @override
  Widget build(BuildContext context) {
    final location = Location.fetchByID(_locationID);
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




















