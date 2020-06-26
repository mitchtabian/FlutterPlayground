import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places_provider.dart';
import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: Consumer<GreatPlacesProvider>(
        child: Center(
          child: Text("Got no places yet, start adding some!"),
        ),
        builder: (ctx, greatPlaces, child) =>
        greatPlaces.items.length <= 0 ?
        child :
        ListView.builder(
          itemBuilder: (ctx, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(
                  greatPlaces.items[index].image
                ),
              ),
              title: Text(greatPlaces.items[index].title),
              onTap: (){
                // go to detail page...
              },
            );
          },
          itemCount: greatPlaces.items.length,
        ),
      ),
    );
  }
}






















