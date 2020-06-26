import 'package:flutter/foundation.dart';
import 'dart:io';

import '../models/place.dart';

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
  }

}













