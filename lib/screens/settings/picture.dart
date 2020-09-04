// dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
// models
import '../../models/user.dart';
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
  String _imageBase64;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final bool editMode = args != null ? args['editMode'] : false;
      final User user = args != null ? args['user'] : null;
      if (editMode) {
        setState(() {
          _imageBase64 = user.picture;
        });
      }
    });
  }

  void _pickImage() async {
    final image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    List<int> imageBytes = await image.readAsBytes();
    String base64 = base64Encode(imageBytes);
    if (image != null) {
      setState(() {
        _image = image;
        _imageBase64 = base64;
      });
    }
  }

  void _onSubmit(bool editMode) async {
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

      if (updated) {
        if (editMode) {
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final bool editMode = args != null ? args['editMode'] : false;
    final bytes = _imageBase64 != null ? base64Decode(_imageBase64) : null;
    return ScaffoldContainer(
      appBar: AppBar(
        centerTitle: !editMode,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: editMode
            ? Text(
                'Edit Picture',
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 22),
              )
            : Logo(),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update your profile picture',
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
                          child: this._imageBase64 == null
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
                                  child: Image.memory(
                                    bytes,
                                    fit: BoxFit.cover,
                                    height: 186,
                                    width: 193,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                          color: ColorsHelper.lightBlue,
                          dashPattern: [15],
                          padding: this._imageBase64 == null
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
                  if (!editMode)
                    SizedBox(
                      child: TextButton(
                        label: 'Skip for now',
                        onPress: () {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
                        },
                      ),
                      width: 100,
                    ),
                  SizedBox(
                    child: RoundedButton(
                      disabled: this._image == null,
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
      ),
      topDivider: false,
    );
  }
}
