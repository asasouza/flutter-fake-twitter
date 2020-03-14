// flutter
import 'package:flutter/material.dart';
// widgets
import '../widgets/logo.dart';
import '../widgets/scaffold-container.dart';
import '../widgets/text-input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Log in to Twitter.',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 25,
            ),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextInput(
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email or username',
                  ),
                  SizedBox(height: 20,),
                  TextInput(
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Password',
                  ),
                ],
              ),
            )
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
