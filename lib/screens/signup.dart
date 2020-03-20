// flutter
import 'package:flutter/material.dart';
// widgets
import '../widgets/button-rounded.dart';
import '../widgets/text-input.dart';
import '../widgets/logo.dart';
import '../widgets/scaffold-container.dart';
// helpers
import '../helpers/colors.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      appBar: AppBar(
        title: Logo(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).accentColor,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              child: Column(
                children: <Widget>[
                  Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: ColorsHelper.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    placeholder: 'Username',
                    maxLength: 50,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextInput(
                    placeholder: 'Email',
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 47,
                vertical: 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: SizedBox(
              child: ButtonRounded(
                disabled: true,
                label: 'Next',
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
