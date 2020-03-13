// flutter
import 'package:flutter/material.dart';
// widgets
import '../widgets/logo.dart';
import '../widgets/scaffold-container.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Sign up',
              style: Theme.of(context).textTheme.subhead,
            ),
            onPressed: () {},
          ),
        ],
        title: Logo(),
      ),
      body: Padding(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Log in to Twitter.',
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
      ),
      topDivider: false,
    );
  }
}
