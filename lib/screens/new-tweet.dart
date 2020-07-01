// flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// widgets
import '../widgets/rounded-button.dart';
import '../widgets/scaffold-container.dart';
// providers
import '../providers/tweet.dart';
import '../providers/user.dart';
// Helpers
import '../helpers/colors.dart';

class NewTweetScreen extends StatefulWidget {
  static const routeName = '/new-tweet';

  @override
  _NewTweetScreenState createState() => _NewTweetScreenState();
}

class _NewTweetScreenState extends State<NewTweetScreen> {
  final int contentMaxLength = 140;
  Map<String, String> _formData = {
    'content': '',
  };
  double _contentSize = 0;
  bool _isLoading = false;
  bool _isValid = false;

  void _saveInputValue(String input, dynamic value) {
    _formData[input] = value;
    setState(() {
      _isValid = _formData['content'] != '';
      _contentSize = value.toString().length / this.contentMaxLength;
    });
  }

  void _onSubmit() async {
    if (this._isValid) {
      setState(() {
        _isLoading = true;
      });
      final created = await Provider.of<TweetProvider>(
        context,
        listen: false,
      ).createTweet(this._formData['content']);
      Navigator.of(context).pop(created);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return ScaffoldContainer(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            child: SizedBox(
              child: RoundedButton(
                disabled: !this._isValid,
                isLoading: this._isLoading,
                label: 'Tweet',
                onPress: this._onSubmit,
              ),
              width: 100,
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: ColorsHelper.darkGray,
                    child: Image.network(user['picture']),
                    radius: 20,
                  ),
                  Form(
                    child: Container(
                      child: TextFormField(
                        cursorColor: ColorsHelper.lightBlue,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 0,
                          ),
                          counterText: '',
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'What\'s happening?',
                          hintStyle: Theme.of(context).textTheme.body2.apply(
                                color: ColorsHelper.darkGray,
                              ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 20,
                        maxLength: this.contentMaxLength,
                        onChanged: (value) {
                          this._saveInputValue('content', value);
                        },
                        style: Theme.of(context).textTheme.body2,
                      ),
                      width: MediaQuery.of(context).size.width - 70,
                    ),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(15),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: CircularPercentIndicator(
              backgroundColor: ColorsHelper.darkGray.withOpacity(0.3),
              lineWidth: 2.5,
              percent: this._contentSize,
              progressColor: ColorsHelper.lightBlue,
              radius: 25,
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
