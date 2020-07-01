// flutter
import 'package:flutter/foundation.dart';
// models
import 'user.dart';

class Tweet {
  final User author;
  final String content;
  final String createdAt;
  final String id;
  final String updatedAt;
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
}