// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/rounded-button.dart';
import '../widgets/logo.dart';
import '../widgets/scaffold-container.dart';
import '../widgets/text-input.dart';
// screens
import '../screens/signup/signup-email-user.dart';
// helpers
import '../helpers/colors.dart';
// providers
import '../providers/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _formData = {
    'email': '',
    'password': '',
  };
  bool _isValid = false;
  bool _isLoading = false;
  final _passwordFocus = FocusNode();

  void _saveInputValue(String input, dynamic value) {
    _formData[input] = value;

    setState(() {
      _isValid = _formData['email'] != '' && _formData['password'] != '';
    });
  }

  void _onSubmit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    await Provider.of<AuthProvider>(context, listen: false).login(
      _formData['email'],
      _formData['password'],
    );
    setState(() {
      _isLoading = false;
    });
  }

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
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(SignupEmailAndUserScreen.routeName);
            },
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
                          onChanged: (value) =>
                              this._saveInputValue('email', value),
                          onFieldSubmitted: (_) =>
                              _passwordFocus.requestFocus(),
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextInput(
                          focusNode: _passwordFocus,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          onChanged: (value) =>
                              this._saveInputValue('password', value),
                          onFieldSubmitted: (_) => this._onSubmit(),
                          textInputAction: TextInputAction.done,
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
                    key: this._formKey,
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
              child: RoundedButton(
                disabled: !this._isValid,
                label: 'Log in',
                onPress: this._onSubmit,
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
      showModal: this._isLoading,
      modalBody: Center(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 40,
              ),
              Text(
                'Logging in...',
                style: Theme.of(context).textTheme.body1,
              ),
            ],
          ),
          color: ColorsHelper.darkBlue,
          padding: EdgeInsets.all(20),
          width: 200,
        ),
      ),
      topDivider: false,
    );
  }
}
