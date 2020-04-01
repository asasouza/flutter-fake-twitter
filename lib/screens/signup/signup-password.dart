// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../../widgets/button-rounded.dart';
import '../../widgets/text-input.dart';
import '../../widgets/logo.dart';
import '../../widgets/scaffold-container.dart';
// screens
import '../settings/name-description.dart';
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
  Map<String, Map<String, dynamic>> _formData = {
    'password': {
      'isValid': false,
      'value': '',
    },
  };
  bool _isLoading = false;

  bool get _isValid {
    return _formData['password']['isValid'];
  }

  void _saveInputValue(String input, dynamic value) {
    _formData[input]['value'] = value;

    setState(() {
      _formData[input]['isValid'] = false;
    });
  }

  void _onSubmit() async {
    FocusScope.of(context).unfocus();
    if (_isValid) {
      setState(() {
        _isLoading = true;
      });
      final signedUp = await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).signup(_formData['password']['value']);
      setState(() {
        _isLoading = false;
      });
      if(signedUp) {
        Navigator.of(context).pushReplacementNamed(SettingsNameBio.routeName);
      }
    }
  }

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
                          _formData['password']['isValid'] = value.length >= 6;
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
                'Signing up...',
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
