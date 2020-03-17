// flutter
import 'package:flutter/material.dart';
// widgets
import '../widgets/button-rounded.dart';
import '../widgets/logo.dart';
import '../widgets/scaffold-container.dart';
import '../widgets/text-input.dart';
// helpers
import '../helpers/colors.dart';

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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
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
                        SizedBox(
                          height: 20,
                        ),
                        TextInput(
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: FlatButton(
                            child: Text(
                              'Forgot password?',
                              style: Theme.of(context).textTheme.display1,
                            ),
                            onPressed: () {},
                          ),
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
          ),
          Container(
            alignment: Alignment.centerRight,
            child: SizedBox(
              child: ButtonRounded(
                disabled: false,
                label: 'Log in',
                onPress: () {},
              ),
              width: 80,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: ColorsHelper.darkGray,
                ),
              ),
            ),
            padding: EdgeInsets.all(10),
            width: double.infinity,
          ),
        ],
      ),
      topDivider: false,
    );
  }
}
