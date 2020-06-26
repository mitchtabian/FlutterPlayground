import 'package:flutter/foundation.dart';
import 'dart:io';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlacesProvider with ChangeNotifier{

  List<Place> _items = [];

  List<Place> get items{
    return [..._items];
  }

  addPlace(String title, File image,){
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      location: null,
      title: title,
    );
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert(
        table: "user_places",
        data: {
          "id": newPlace.id,
          "title": newPlace.title,
          "image": newPlace.image.path
        }
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData(table: "user_places");
    _items = dataList.map(
            (item) => Place(
              id: item["id"],
              title: item["title"],
              image: File(item["image"]),
              location: null,
            )
    ).toList();
    notifyListeners();
  }
}













