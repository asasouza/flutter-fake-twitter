import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  final String bio;
  final String id;
  bool following;
  final String name;
  final String picture;
  final String pictureThumb;
  final String username;

  User({
    this.bio,
    @required this.id,
    this.following = false,
    this.name,
    @required this.picture,
    @required this.pictureThumb,
    @required this.username,
  });

  toggleFollow() {
    this.following = !this.following;
    notifyListeners();
  }


}
