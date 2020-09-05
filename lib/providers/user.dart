//dart
import 'dart:convert';
import 'dart:async';
import 'dart:io';
// flutter
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// models
import '../models/user.dart';
// helpers
import '../helpers/constants.dart';
import '../helpers/http.dart';

class UserProvider extends ChangeNotifier {
  final String authToken;
  User _user;

  UserProvider({this.authToken}) {
    populateDataFromStorage();
  }

  User get user {
    return _user;
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
        _user = User(
          bio: data['bio'],
          id: data['_id'],
          name: data['name'],
          picture: data['picture'],
          pictureThumb: data['pictureThumb'],
          username: data['username'],
        );
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
        _user.picture = data['picture'];
        _user.pictureThumb = data['pictureThumb'];
        SharedPreferences.getInstance().then((storage) {
          storage.setString(
              Constants.storageUserKey,
              json.encode({
                'bio': _user.bio,
                'name': _user.name,
                'picture': _user.picture,
                'pictureThumb': _user.pictureThumb,
                'username': _user.username,
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
      final userData = json.decode(storage.getString(Constants.storageUserKey));
      final authData = json.decode(storage.getString(Constants.storageAuthKey));
      _user = User(
        bio: userData['bio'],
        id: authData['id'],
        name: userData['name'],
        picture: userData['picture'],
        pictureThumb: userData['pictureThumb'],
        username: userData['username'],
      );
      notifyListeners();

      _user.fetchInfo(authToken: authToken).then((User user) {
        _user = user;
        notifyListeners();
      });
    });
  }
}
