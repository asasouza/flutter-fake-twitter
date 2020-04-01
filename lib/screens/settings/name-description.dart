// flutter
import 'package:flutter/material.dart';
// widgets
import '../../widgets/button-rounded.dart';
import '../../widgets/logo.dart';
import '../../widgets/scaffold-container.dart';
import '../../widgets/text-button.dart';
import '../../widgets/text-input.dart';
// helpers
import '../../helpers/colors.dart';

class SettingsNameBio extends StatefulWidget {
  static const routeName = '/settings/name-bio';

  @override
  _SettingsNameBioState createState() => _SettingsNameBioState();
}

class _SettingsNameBioState extends State<SettingsNameBio> {
  final _bioFocus = FocusNode();
  final Map<String, Map<String, dynamic>> _formData = {
    'bio': {
      'isValid': false,
      'value': '',
    },
    'name': {
      'isValid': false,
      'value': '',
    },
  };
  bool _isLoading = false;

  bool get _isValid {
    return _formData['bio']['isValid'] && _formData['name']['isValid'];
  }

  void _saveInputValue(String input, dynamic value) {
    _formData[input]['value'] = value;
  }

  void _onSubmit() {
    if (_isValid) {
      setState(() {
        _isLoading = true;
      });
      print(_formData);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      appBar: AppBar(
        title: Logo(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Describe yourself',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'What makes you special? Don\'t thin too hard, just have fun with it.',
                      style: TextStyle(
                        color: ColorsHelper.darkGray,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Form(
                      child: Column(
                        children: <Widget>[
                          TextInput(
                            onChanged: (value) =>
                                this._saveInputValue('name', value),
                            onFieldSubmitted: (_) {
                              _bioFocus.requestFocus();
                            },
                            placeholder: 'Your name',
                            validator: (String value) {
                              String error;
                              if (value.length > 50) {
                                error = 'Must be 50 characters or fewer.';
                              } else if (value.isEmpty) {
                                error = '';
                              }
                              setState(() {
                                _formData['name']['isValid'] = error == null;
                              });
                              return error;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextInput(
                            focusNode: this._bioFocus,
                            maxLength: 160,
                            multiLine: true,
                            onChanged: (value) =>
                                this._saveInputValue('bio', value),
                            onFieldSubmitted: (_) => this._onSubmit(),
                            placeholder: 'Your bio',
                            validator: (String value) {
                              String error;
                              if (value.length > 160) {
                                error = 'Must be 160 characters or fewer.';
                              } else if (value.isEmpty) {
                                error = '';
                              }
                              setState(() {
                                _formData['bio']['isValid'] = error == null;
                              });
                              return error;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                padding: EdgeInsets.all(20),
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  child: TextButton(
                    label: 'Skip for now',
                    onPress: () {
                      Navigator.of(context).pushReplacementNamed('ChangePhoto');
                    },
                  ),
                  width: 100,
                ),
                SizedBox(
                  child: ButtonRounded(
                    disabled: !this._isValid,
                    label: 'Next',
                    onPress: this._onSubmit,
                  ),
                  width: 80,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: ColorsHelper.darkGray,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
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
                'Setting up profile...',
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
