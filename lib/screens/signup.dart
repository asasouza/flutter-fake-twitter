// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../widgets/button-rounded.dart';
import '../widgets/text-input.dart';
import '../widgets/logo.dart';
import '../widgets/scaffold-container.dart';
// providers
import '../providers/auth.dart';
// helpers
import '../helpers/colors.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _loginData = {
    'username': '',
    'password': '',
  };
  bool _isValid = false;
  bool _isLoading = false;
  final _emailFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();

    _emailFocus.dispose();
  }

  void _saveInputValue(String input, dynamic value) {
    _loginData[input] = value;

    setState(() {
      _isValid = true;
    });
  }

  void _onSubmit() {
    print('Submit');
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
                      validator: (value) {
                        if (value.length > 50) {
                          return 'Must be 50 characters or fewer';
                        }
                        return null;
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
