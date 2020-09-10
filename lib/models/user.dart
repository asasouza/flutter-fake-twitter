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
  String picture;
  String pictureThumb;
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

  Future<User> fetchInfo({String authToken}) {
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
          following: userData['isFollowing'],
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

  Future<List<User>> fetchContacts({
    String authToken,
    String type = 'following',
    int offset = 0,
    int limit = 9999,
  }) {
    final url =
        '${Constants.baseURL}/users/$id/$type?offset=$offset&limit=$limit';
    return HttpHelper.get(url, token: authToken).then((response) {
      final List<User> contacts = [];
      if (response.statusCode == 200) {
        final decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;
        decodedResponse[type].forEach((user) {
          contacts.add(User(
            bio: user['bio'],
            id: user['_id'],
            following: user['isFollowing'],
            name: user['name'],
            picture: user['picture'],
            pictureThumb: user['pictureThumb'],
            username: user['username'],
          ));
        });
      }
      return contacts;
    });
  }

  void toggleFollow(String authToken) {
    final oldFollowing = following;
    final oldFollowersCount = followersCount;
    final url =
        '${Constants.baseURL}/users/$id/${following ? 'unfollow' : 'follow'}';
    followersCount = following ? followersCount - 1 : followersCount + 1;
    following = !following;
    notifyListeners();
    HttpHelper.put(
      url,
      token: authToken,
    ).then((response) {
      if (response.statusCode >= 400) {
        followersCount = oldFollowersCount;
        following = oldFollowing;
        notifyListeners();
      }
    });
  }
}
