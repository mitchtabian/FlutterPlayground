import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {

  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth{
    return token != null;
  }

  String get token {
    if(_expiryDate != null
        && _expiryDate.isAfter(DateTime.now())
        && _token != null
    ){
      return _token;
    }
    return null;
  }


  Future<void> _authenticate(String email, String password, String urlSegment) async{
    var url = "https://identitytoolkit.googleapis.com/v1/accounts:${urlSegment}?key=AIzaSyCCcpjkNiDp-C6J0AvksVKkhh3Iq1noVpI";
    try{
      final response = await http.post(
          url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          })
      );
      final extractedBody = json.decode(response.body);
      if(extractedBody["error"] != null){
        throw HttpException(extractedBody["error"]["message"]);
      }
      _token = extractedBody["idToken"];
      _userId = extractedBody["localId"];
      _expiryDate = DateTime.now().add(
          Duration(
              seconds: int.parse(extractedBody["expiresIn"])
          )
      );
      notifyListeners();
    }catch(error){
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async{
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async{
    return _authenticate(email, password, "signInWithPassword");
  }
}



















