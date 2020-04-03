// flutter
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
// widgets
import '../../widgets/scaffold-container.dart';
import '../../widgets/logo.dart';
import '../../widgets/button-rounded.dart';
import '../../widgets/text-button.dart';
// helper
import '../../helpers/colors.dart';

class SettingsPictureScreen extends StatefulWidget {
  static const routeName = '/settings/picture';

  @override
  _SettingsPictureScreenState createState() => _SettingsPictureScreenState();
}

class _SettingsPictureScreenState extends State<SettingsPictureScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      appBar: AppBar(
        title: Logo(),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Pick a profile picture',
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
                      'Have a favorite selfie? Upload it now.',
                      style: TextStyle(
                        color: ColorsHelper.darkGray,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.photo_camera,
                                color: ColorsHelper.lightBlue,
                                size: 80,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Upload',
                                style: TextStyle(
                                  color: ColorsHelper.lightBlue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          color: ColorsHelper.lightBlue,
                          dashPattern: [15],
                          padding: EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 40,
                          ),
                          radius: Radius.circular(20),
                          strokeWidth: 3,
                        ),
                        onTap: () => print('teste'),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                padding: EdgeInsets.all(20),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    child: TextButton(
                      label: 'Skip for now',
                      onPress: () {},
                    ),
                    width: 100,
                  ),
                  SizedBox(
                    child: ButtonRounded(
                      disabled: true,
                      isLoading: false,
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
      ),
      topDivider: false,
    );
  }
}
