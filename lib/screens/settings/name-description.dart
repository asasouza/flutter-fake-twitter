// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import '../../widgets/rounded-button.dart';
import '../../widgets/logo.dart';
import '../../widgets/scaffold-container.dart';
import '../../widgets/text-button.dart';
import '../../widgets/text-input.dart';
// models
import '../../models/user.dart';
// screens
import './picture.dart';
// providers
import '../../providers/user.dart';
// helpers
import '../../helpers/colors.dart';

class SettingsNameBioScreen extends StatefulWidget {
  static const routeName = '/settings/name-bio';

  @override
  _SettingsNameBioScreenState createState() => _SettingsNameBioScreenState();
}

class _SettingsNameBioScreenState extends State<SettingsNameBioScreen> {
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
  TextEditingController _bioController;
  TextEditingController _nameController;

  bool get _isValid {
    return _formData['bio']['isValid'] && _formData['name']['isValid'];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final bool editMode = args != null ? args['editMode'] : false;
      final User user = args != null ? args['user'] : null;
      if (editMode) {
        _formData['bio']['value'] = user.bio;
        _formData['name']['value'] = user.name;
        _formData['bio']['isValid'] = true;
        _formData['name']['isValid'] = true;
        _bioController = TextEditingController(text: user.bio);
        _nameController = TextEditingController(text: user.name);
        setState(() {});
      }
    });
  }

  void _saveInputValue(String input, dynamic value) {
    _formData[input]['value'] = value;
  }

  void _onSubmit(bool editMode) async {
    if (_isValid) {
      setState(() {
        _isLoading = true;
      });
      final updated = await Provider.of<UserProvider>(
        context,
        listen: false,
      ).updateUserInfo(
        bio: _formData['bio']['value'],
        name: _formData['name']['value'],
      );
      if (updated) {
        if (editMode) {
          Navigator.of(context).pop();
        } else {
          Navigator.of(context)
              .pushReplacementNamed(SettingsPictureScreen.routeName);
        }
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final bool editMode = args != null ? args['editMode'] : false;
    return ScaffoldContainer(
      appBar: AppBar(
        centerTitle: !editMode,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: editMode
            ? Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 22),
              )
            : Logo(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                child: Column(
                  children: <Widget>[
                    Text(
                      editMode ? 'Update your info' : 'Describe yourself',
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
                            controller: editMode ? _nameController : null,
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
                            controller: editMode ? _bioController : null,
                            focusNode: this._bioFocus,
                            maxLength: 160,
                            multiLine: true,
                            onChanged: (value) =>
                                this._saveInputValue('bio', value),
                            onFieldSubmitted: (_) => this._onSubmit(editMode),
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
                if (!editMode)
                  SizedBox(
                    child: TextButton(
                      label: 'Skip for now',
                      onPress: () {
                        Navigator.of(context).pushReplacementNamed(
                            SettingsPictureScreen.routeName);
                      },
                    ),
                    width: 100,
                  ),
                SizedBox(
                  child: RoundedButton(
                    disabled: !this._isValid,
                    isLoading: this._isLoading,
                    label: editMode ? 'Save' : 'Next',
                    onPress: () => this._onSubmit(editMode),
                  ),
                  width: 80,
                ),
              ],
              mainAxisAlignment: editMode
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.spaceBetween,
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
      topDivider: false,
    );
  }
}
