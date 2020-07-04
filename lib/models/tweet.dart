// flutter
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

  void toggleLike(String authToken) {
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
}
