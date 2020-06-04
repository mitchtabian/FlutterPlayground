import 'package:firstflutterapp/screens/location_detail/location_detail.dart';
import 'package:flutter/material.dart';

import 'package:firstflutterapp/widgets/text_section.dart';
import 'package:firstflutterapp/widgets/image_banner.dart';
import 'package:firstflutterapp/models/location.dart';
import '../../app.dart';

class Locations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final locations = Location.fetchAll();

    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: ListView(
        children: <Widget>[
          ...locations.map((location) =>
              GestureDetector(
                child: Text(location.name),
                onTap: () => _onLocationTap(context, location.id),
              ),
          ).toList(),
        ],
      ),
    );
  }

  _onLocationTap(BuildContext context, int locationId){
    Navigator.pushNamed(context, LocationDetailRoute, arguments: {"id": locationId} );
  }
}






















