// flutter
import 'dart:convert';
import 'package:flutter/foundation.dart';
// models
import 'user.dart';
// Helpers
import '../helpers/http.dart';
import '../helpers/constants.dart';

class Tweet extends ChangeNotifier {
  final User author;
  final String content;
  final DateTime createdAt;
  final String id;
  final DateTime updatedAt;
  bool isLiked;
  int likesCount;

  Tweet({
    @required this.author,
    @required this.content,
    @required this.createdAt,
    @required this.id,
    @required this.updatedAt,
    this.isLiked = false,
    @required this.likesCount,
  });

  void toggleLike(String authToken, {bool forceToggle, int numLikes}) {
    if (forceToggle != null) {
      likesCount = numLikes;
      isLiked = forceToggle;
      return notifyListeners();
    }

    final oldIsLiked = isLiked;
    final oldLikesCount = likesCount;
    final url =
        '${Constants.baseURL}/tweets/$id/${isLiked ? 'unlike' : 'like'}';
    likesCount = isLiked ? likesCount - 1 : likesCount + 1;
    isLiked = !isLiked;
    notifyListeners();

    HttpHelper.put(
      url,
      token: authToken,
    ).then((response) {
      if (response.statusCode >= 400) {
        likesCount = oldLikesCount;
        isLiked = oldIsLiked;
        notifyListeners();
      }
    });
  }

  Future<List<User>> fetchLikes(int offset, int limit, { String authToken }) {
    final url =
        '${Constants.baseURL}/tweets/$id/likes?offset=$offset&limit=$limit';
    return HttpHelper.get(url, token: authToken).then((response) {
      final List<User> loadedLikes = [];
      if (response.statusCode == 200) {
        final decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;
        decodedResponse['likes'].forEach((user) {
          loadedLikes.add(
            User(
              bio: user['bio'],
              following: user['isFollowing'],
              id: user['_id'],
              name: user['name'],
              picture: user['picture'],
              pictureThumb: user['pictureThumb'],
              username: user['username'],
            ),
          );
        });
      }
      return loadedLikes;
    });
  }
}
