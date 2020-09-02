// flutter
import 'package:flutter/foundation.dart';
import 'dart:convert';
// helpers
import '../helpers/constants.dart';
import '../helpers/http.dart';

class User extends ChangeNotifier {
  final String bio;
  final DateTime createdAt;
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
    this.createdAt,
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

  Future<User> fetchInfo({ String authToken }) {
    final url = '${Constants.baseURL}/users/$id';
    return HttpHelper.get(url, token: authToken).then((response) {
      if (response.statusCode == 200) {
        final decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final userData = decodedResponse['user'];
        return User(
          bio: userData['bio'],
          createdAt: DateTime.parse(userData['createdAt']),
          followersCount: userData['followersCount'],
          followingCount: userData['followingCount'],
          id: userData['_id'],
          following: false,
          name: userData['name'],
          picture: userData['picture'],
          pictureThumb: userData['pictureThumb'],
          tweetsCount: userData['totalTweets'],
          username: userData['username'],
        );
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
