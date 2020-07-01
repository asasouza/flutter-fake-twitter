import 'package:flutter/foundation.dart';

class User {
  final String id;
  // final String name;
  final String picture;
  final String pictureThumb;
  final String username;

  User({
    @required this.id,
    // @required this.name,
    @required this.picture,
    @required this.pictureThumb,
    @required this.username,
  });
}
