// flutter
import 'package:flutter/foundation.dart';
import 'dart:convert';
// helpers
import '../helpers/constants.dart';
import '../helpers/http.dart';

class User extends ChangeNotifier {
  final String bio;
  int followersCount;
  final int followingCount;
  final String id;
  bool following;
  final String name;
  final String picture;
  final String pictureThumb;
  final int tweetsCount;
  final String username;
  
  User({
    this.bio,
    this.followersCount = 0,
    this.followingCount = 0,
    @required this.id,
    this.following = false,
    this.name,
    @required this.picture,
    @required this.pictureThumb,
    this.tweetsCount = 0,
    @required this.username,
  });

  Future<User> fetchInfo() {
    final url = '${Constants.baseURL}/users/$id';
    print('call fetchIndo');
    return HttpHelper.get(url)
    .then((response) {
      if(response.statusCode == 200) {
        final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
        print(decodedResponse);
      }
      return this;
    });

  }

  void toggleFollow(String authToken) {
    this.following = !this.following;
    this.followersCount++;
    notifyListeners();
  }
}
