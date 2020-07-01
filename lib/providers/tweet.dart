// flutter
import 'dart:convert';
import 'package:flutter/material.dart';
// helper
import '../helpers/constants.dart';
import '../helpers/http.dart';

class TweetProvider extends ChangeNotifier {
  final String authToken;

  TweetProvider({this.authToken});

  Future<bool> createTweet(String content) async {
    return HttpHelper.post(
      '${Constants.baseURL}/tweets',
      body: {'content': content},
      token: authToken,
    ).then((response) {
      if(response.statusCode == 201) {
        final data = json.decode(response.body);
        print(data);  
        return true;
      }
      return false;
    });
  }
}
