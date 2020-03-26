// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../../widgets/button-rounded.dart';
import '../../widgets/text-input.dart';
import '../../widgets/logo.dart';
import '../../widgets/scaffold-container.dart';
// providers
import '../../providers/auth.dart';
// helpers
import '../../helpers/colors.dart';

class SignupPasswordScreen extends StatefulWidget {
  static const routeName = '/signup/password';

  @override
  _SignupPasswordScreenState createState() => _SignupPasswordScreenState();
}

class _SignupPasswordScreenState extends State<SignupPasswordScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, Map<String, dynamic>> _loginData = {
    'password': {
      'isValid': false,
      'value': '',
    },
  };

  bool get _isValid {
    return _loginData['password']['isValid'];
  }

  void _saveInputValue(String input, dynamic value) {
    _loginData[input]['value'] = value;

    setState(() {
      _loginData[input]['isValid'] = false;
    });
  }

  void _onSubmit() {
    if (_isValid) {
      print('SUBMITED');
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              child: Form(
                child: Column(
                  children: <Widget>[
                    Text(
                      'You\'ll need a password',
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: ColorsHelper.white,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Make sure it\'s 6 characters or more.',
                      style: TextStyle(
                        color: ColorsHelper.darkGray,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextInput(
                      isPassword: true,
                      onChanged: (value) =>
                          this._saveInputValue('password', value),
                      onFieldSubmitted: (_) => this._onSubmit(),
                      placeholder: 'Password',
                      validator: (String value) {
                        setState(() {
                          _loginData['password']['isValid'] = value.length > 6;
                        });
                        return value.length < 6 ? '' : null;
                      },
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                key: this._formKey,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: SizedBox(
              child: ButtonRounded(
                disabled: !this._isValid,
                label: 'Next',
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
      topDivider: false,
    );
  }
}
