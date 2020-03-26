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

class SignupEmailAndUserScreen extends StatefulWidget {
  static const routeName = '/signup/email-user';

  @override
  _SignupEmailAndUserScreenState createState() => _SignupEmailAndUserScreenState();
}

class _SignupEmailAndUserScreenState extends State<SignupEmailAndUserScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, Map<String, dynamic>> _loginData = {
    'username': {
      'isValid': false,
      'value': '',
    },
    'email': {
      'isValid': false,
      'value': '',
    },
  };
  final _emailFocus = FocusNode();

  bool get _isValid {
    return _loginData['email']['isValid'] && _loginData['username']['isValid'];
  }

  void _saveInputValue(String input, dynamic value) {
    _loginData[input]['value'] = value;

    setState(() {
      _loginData[input]['isValid'] = false;
    });
  }

  void _onSubmit() {
    if (_isValid) {
      Provider.of<AuthProvider>(context, listen: false).setEmailAndUsername(
        _loginData['email']['value'],
        _loginData['username']['value'],
      );
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
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            'Create your account',
            style: TextStyle(
              fontSize: 32,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              color: ColorsHelper.white,
            ),
          ),
          Expanded(
            child: Padding(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextInput(
                      maxLength: 50,
                      onChanged: (value) =>
                          this._saveInputValue('username', value),
                      onFieldSubmitted: (_) => this._emailFocus.requestFocus(),
                      placeholder: 'Username',
                      validator: (value) async {
                        final error = await auth.isValidUsername(value);
                        setState(() {
                          _loginData['username']['isValid'] = error == null;
                        });
                        return error;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextInput(
                        focusNode: this._emailFocus,
                        onChanged: (value) =>
                            this._saveInputValue('email', value),
                        onFieldSubmitted: (_) => this._onSubmit(),
                        placeholder: 'Email',
                        validator: (value) async {
                          final error = await auth.isValidEmail(value);
                          setState(() {
                            _loginData['email']['isValid'] = error == null;
                          });
                          return error;
                        }),
                  ],
                ),
                key: this._formKey,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 47,
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
