// flutter
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// providers
import '../providers/auth.dart';
import '../providers/user.dart';
// models
import '../models/user.dart';
// screens
import '../screens/profile.dart';
// helpers
import '../helpers/colors.dart';

class MainDrawer extends StatelessWidget {
  Uint8List bytes;

  void _navigateProfile(BuildContext context, User user) {
    if (ModalRoute.of(context).settings.name != ProfileScreen.routeName) {
      Navigator.of(context)
          .pushNamed(ProfileScreen.routeName, arguments: {'user': user});
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (bytes == null) {
      bytes = base64.decode(user.pictureThumb);
    }
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: ColorsHelper.darkGray,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.memory(bytes),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '@${user.username}',
                      style: TextStyle(
                        color: ColorsHelper.darkGray,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Text(
                          user.followingCount.toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Text('Following',
                            style: TextStyle(
                                color: ColorsHelper.darkGray, fontSize: 18)),
                        SizedBox(width: 15),
                        Text(
                          user.followersCount.toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Text('Followers',
                            style: TextStyle(
                                color: ColorsHelper.darkGray, fontSize: 18)),
                      ],
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                padding: EdgeInsets.only(
                  bottom: 15,
                  left: 30,
                  right: 30,
                  top: 10,
                ),
              ),
              Divider(),
              Padding(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: Icon(
                        Icons.person_outline,
                        color: ColorsHelper.darkGray,
                        size: 35,
                      ),
                      onTap: () => _navigateProfile(context, user),
                      title: Text('Profile', style: TextStyle(fontSize: 18)),
                    )
                  ],
                ),
                padding: EdgeInsets.only(
                  bottom: 5,
                  left: 30,
                  right: 30,
                  top: 5,
                ),
              ),
              Divider(),
              Padding(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                      },
                      title: Text(
                        'Logout',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
