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
                            placeholder: 'Your name',
                          ),
                          TextInput(
                            maxLength: 160,
                            multiLine: true,
                            placeholder: 'Your bio',
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
                    disabled: false,
                    label: 'Skip for now',
                    onPress: () {},
                  ),
                  width: 100,
                ),
                SizedBox(
                  child: ButtonRounded(
                    disabled: true,
                    label: 'Next',
                    onPress: () {},
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
      topDivider: false,
    );
  }
}
