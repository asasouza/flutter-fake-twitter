//dart
import 'dart:convert';
import 'dart:async';
// flutter
import 'package:flutter/material.dart';
// helpers
import '../helpers/constants.dart';
import '../helpers/http.dart';

class AuthProvider extends ChangeNotifier {
  String _username;
  String _email;
  String _userToken;

  Future<void> login(String email, String password) async {
    return HttpHelper.post(
      '${Constants.baseURL}/login',
      body: {'email': email, 'password': password},
    ).then((data) {
      print(data.body);
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
}
