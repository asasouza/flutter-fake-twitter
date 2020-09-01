// flutter
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import './rounded-button.dart';
// models
import '../models/user.dart';
// providers
import '../providers/auth.dart';
import '../providers/user.dart';
// screens
import '../screens/profile.dart';

class UserItem extends StatelessWidget {
  void _toggleFollow(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    user.toggleFollow(auth.token);
  }

  void _navigateProfile(BuildContext context, User user) {
    Navigator.of(context)
        .pushNamed(ProfileScreen.routeName, arguments: {'user': user});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final userLogged = Provider.of<UserProvider>(context, listen: false).user;
    final bytes = base64.decode(user.pictureThumb);
    return Padding(
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Row(
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(23),
                      child: Image.memory(bytes),
                    ),
                    radius: 23,
                    backgroundColor: Colors.grey,
                  ),
                  margin: EdgeInsets.only(right: 10),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.display2,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Text(
                      '@${user.username}',
                      style: Theme.of(context).textTheme.display3,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      user.bio,
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            onTap: () => this._navigateProfile(context, user),
          ),
          if (user.id != userLogged.id)
            SizedBox(
              child: RoundedButton(
                label: user.following ? 'Following' : 'Follow',
                onPress: () => this._toggleFollow(context),
                outline: !user.following,
                padding: 0,
              ),
              height: 33,
              width: 100,
            ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    );
  }
}
