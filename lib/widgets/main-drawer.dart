// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// providers
import '../providers/auth.dart';
import '../providers/user.dart';
// helpers
import '../helpers/colors.dart';

class MainDrawer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
                      child: Image.network(
                        user.picture,
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
                          '789',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Text('Following',
                            style: TextStyle(
                                color: ColorsHelper.darkGray, fontSize: 18)),
                        SizedBox(width: 15),
                        Text(
                          '696',
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
                      title: Text(
                        'Settings and privacy',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: Icon(Icons.exit_to_app, color: Colors.white,),
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false).logout();
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
