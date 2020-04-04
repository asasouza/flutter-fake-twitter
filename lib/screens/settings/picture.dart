// dart
import 'dart:io';
// flutter
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// widgets
import '../../widgets/scaffold-container.dart';
import '../../widgets/logo.dart';
import '../../widgets/rounded-button.dart';
import '../../widgets/text-button.dart';
// screens
import '../home.dart';
// providers
import '../../providers/user.dart';
// helper
import '../../helpers/colors.dart';

class SettingsPictureScreen extends StatefulWidget {
  static const routeName = '/settings/picture';

  @override
  _SettingsPictureScreenState createState() => _SettingsPictureScreenState();
}

class _SettingsPictureScreenState extends State<SettingsPictureScreen> {
  File _image;
  bool _isLoading = false;

  void _pickImage() async {
    final image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _onSubmit() async {
    if (_image != null) {
      setState(() {
        _isLoading = true;
      });

      final updated = await Provider.of<UserProvider>(
        context,
        listen: false,
      ).updateUserPicture(_image);

      setState(() {
        _isLoading = false;
      });

      if(updated) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    }
  }

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
                      child: InkWell(
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          child: this._image == null
                              ? Column(
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
                                )
                              : ClipRRect(
                                  child: Image.file(
                                    this._image,
                                    fit: BoxFit.cover,
                                    height: 186,
                                    width: 193,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                          color: ColorsHelper.lightBlue,
                          dashPattern: [15],
                          padding: this._image == null
                              ? EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical: 40,
                                )
                              : EdgeInsets.all(3),
                          radius: Radius.circular(20),
                          strokeWidth: 3,
                        ),
                        onTap: Feedback.wrapForTap(this._pickImage, context),
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
                      onPress: () {
                        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                      },
                    ),
                    width: 100,
                  ),
                  SizedBox(
                    child: RoundedButton(
                      disabled: this._image == null,
                      isLoading: this._isLoading,
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
      ),
      topDivider: false,
    );
  }
}
