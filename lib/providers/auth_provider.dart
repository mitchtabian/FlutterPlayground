import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {

  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth{
    return token != null;
  }

  String get userId{
    return _userId;
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

  logout(){
    if(_authTimer != null){
      _authTimer.cancel();
      _authTimer = null;
    }
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }

  autoLogout(){
    if(_authTimer != null){
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(
        Duration(seconds: timeToExpiry),
        logout
    );
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey("userData")){
      return false;
    }
    final extractedUserData = json.decode(prefs.getString("userData")) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData["expiryDate"]);
    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }
    _expiryDate = expiryDate;
    _userId = extractedUserData["userId"];
    _token = extractedUserData["token"];
    notifyListeners();
    autoLogout();
    return true;
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
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiryDate.toIso8601String(),
      });
      prefs.setString("userData", userData);
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



















