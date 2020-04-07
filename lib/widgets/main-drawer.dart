// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// providers
import '../providers/user.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    print(user);
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                child: Image.network(user['picture']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
