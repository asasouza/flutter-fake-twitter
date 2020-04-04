//dart
import 'dart:convert';
import 'dart:async';
import 'dart:io';
// flutter
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// helpers
import '../helpers/constants.dart';
import '../helpers/http.dart';

class UserProvider extends ChangeNotifier {
  final String authToken;
  String _bio;
  String _name;
  String _picture;
  String _pictureThumb;
  String _username;

  UserProvider({this.authToken}) {
    populateDataFromStorage();
  }

  Future<bool> updateUserInfo({
    String bio,
    String name,
  }) async {
    return HttpHelper.put(
      '${Constants.baseURL}/users',
      body: {'bio': bio, 'name': name},
      token: authToken,
    ).then((response) {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _bio = data['bio'];
        _name = data['name'];
        _picture = data['username'];
        _pictureThumb = data['pictureThumb'];
        _username = data['username'];
        SharedPreferences.getInstance().then((storage) {
          storage.setString(
              Constants.storageUserKey,
              json.encode({
                'bio': data['bio'],
                'name': data['name'],
                'picture': data['picture'],
                'pictureThumb': data['pictureThumb'],
                'username': data['username'],
              }));
        });
        notifyListeners();
        return true;
      }
      return false;
    });
  }

  Future<bool> updateUserPicture(File picture) async {
    return HttpHelper.uploadImage(
      '${Constants.baseURL}/users',
      picture,
      fieldName: 'picture',
      method: 'PUT',
      token: authToken,
    ).then((response) {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _picture = data['picture'];
        _pictureThumb = data['pictureThumb'];
        SharedPreferences.getInstance().then((storage) {
          storage.setString(
              Constants.storageUserKey,
              json.encode({
                'bio': _bio,
                'name': _name,
                'picture': _picture,
                'pictureThumb': _pictureThumb,
                'username': _username,
              }));
        });
        notifyListeners();
        return true;
      }
      return false;
    });
  }

  void populateDataFromStorage() {
    SharedPreferences.getInstance().then((storage) {
      if (!storage.containsKey(Constants.storageUserKey)) {
        return;
      }
      final data = json.decode(storage.getString(Constants.storageUserKey));
      _bio = data['bio'];
      _name = data['name'];
      _picture = data['username'];
      _pictureThumb = data['pictureThumb'];
      _username = data['username'];

      notifyListeners();
    });
  }
}
