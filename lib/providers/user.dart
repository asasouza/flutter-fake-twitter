//dart
import 'dart:convert';
import 'dart:async';
// flutter
import 'package:flutter/material.dart';
// helpers
import '../helpers/constants.dart';
import '../helpers/http.dart';

class UserProvider extends ChangeNotifier {
  final String authToken;
  String _bio;
  String _name;
  String _photoUrl;
  String _photoThumbUrl;

  UserProvider({ this.authToken });

  Future<bool> updateUserInfo({
    String bio,
    String name,
    String photo,
  }) async {
    return HttpHelper.put(
      '${Constants.baseURL}/users',
      body: {'bio': bio, 'name': name},
      token: authToken,
    ).then((response) {
      print(response.body);
      return true;
    });
  }
}
