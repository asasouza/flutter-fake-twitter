//dart
import 'dart:convert';
import 'dart:async';
// flutter
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// helpers
import '../helpers/constants.dart';
import '../helpers/http.dart';

class AuthProvider extends ChangeNotifier {
  String _username;
  String _email;
  String _userToken;
  String _userId;

  String get token {
    return _userToken;
  }

  bool get isAuthenticated {
    return _userToken != null;
  }

  Future<void> login(String email, String password) async {
    return HttpHelper.post(
      '${Constants.baseURL}/login',
      body: {'email': email, 'password': password},
    ).then((response) {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _userId = data['userID'];
        _userToken = data['token'];

        SharedPreferences.getInstance().then((storage) {
          storage.setString(
              Constants.storageAuthKey,
              json.encode({
                "id": _userId,
                "token": _userToken,
              }));
          storage.setString(
              Constants.storageUserKey,
              json.encode({
                "bio": data['bio'],
                "name": data['name'],
                "picture": data['picture'],
                "pictureThumb": data['pictureThumb'],
                "username": data['username'],
              }));
        });
        notifyListeners();
      }
    });
  }

  Future<String> isValidEmail(String email) async {
    final response =
        await HttpHelper.post('${Constants.baseURL}/validate-email', body: {
      'email': email,
    });
    if (response.statusCode != 200) {
      final error = json.decode(response.body)['data'][0]['msg'];
      return error;
    }
    return null;
  }

  Future<String> isValidUsername(String username) async {
    final response =
        await HttpHelper.post('${Constants.baseURL}/validate-username', body: {
      'username': username,
    });
    if (response.statusCode != 200) {
      final error = json.decode(response.body)['data'][0]['msg'];
      return error;
    }
    return null;
  }

  void setEmailAndUsername(String email, String username) {
    _email = email;
    _username = username;
  }

  Future<bool> signup(String password) {
    return HttpHelper.post('${Constants.baseURL}/signup', body: {
      'email': _email,
      'password': password,
      'username': _username,
    }).then((response) {
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        _userToken = data['token'];

        SharedPreferences.getInstance().then((storage) {
          storage.setString(
              Constants.storageAuthKey,
              json.encode({
                'id': data['userID'],
                'token': data['token'],
              }));
        });
        notifyListeners();
        return true;
      }
      return false;
    });
  }

  Future<bool> autoLogin() async {
    final storage = await SharedPreferences.getInstance();
    if (!storage.containsKey(Constants.storageAuthKey)) {
      return false;
    }
    final userData =
        json.decode(storage.getString(Constants.storageAuthKey)) as Map<String, Object>;

    _userToken = userData['token'];
    _userId = userData['id'];
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _userToken = null;
    _userId = null;

    SharedPreferences.getInstance().then((storage) {
      storage.clear();
    });
    notifyListeners();
  }
}
