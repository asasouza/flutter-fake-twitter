//dart
import 'dart:convert';
import 'dart:async';
// flutter
import 'package:flutter/material.dart';
// packages
import 'package:http/http.dart' as http;
// helpers
import '../helpers/constants.dart';

class AuthProvider extends ChangeNotifier {
  String _userToken;

  Future<void> login(String email, String password) async {
    return http.post(
      '${Constants.baseURL}/login',
      body: {
        'email': email,
        'password': password
      },
    ).then((data) {
      print(data.body);
    });
  }
}
