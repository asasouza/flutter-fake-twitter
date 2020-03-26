//dart
import 'dart:convert';
import 'dart:async';
// flutter
import 'package:flutter/material.dart';
// helpers
import '../helpers/constants.dart';
import '../helpers/http.dart';

class AuthProvider extends ChangeNotifier {
  String _userToken;

  Future<void> login(String email, String password) async {
    return HttpHelper.post(
      '${Constants.baseURL}/login',
      body: {
        'email': email,
        'password': password
      },
    ).then((data) {
      print(data.body);
    });
  }

  Future<String> isValidEmail(String email) async {
    return await Future.delayed(Duration(seconds: 2), () {
      return null;
    });
  }

  Future<String> isValidUsername(String username) async {
    return await Future.delayed(Duration(seconds: 2), () {
      return null;
    });
  }
}
