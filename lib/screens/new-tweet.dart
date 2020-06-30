// flutter
import 'package:flutter/material.dart';
// widgets
import '../widgets/rounded-button.dart';
import '../widgets/scaffold-container.dart';
// Helpers
import '../helpers/colors.dart';

class NewTweetScreen extends StatefulWidget {
  static const routeName = '/new-tweet';

  @override
  _NewTweetScreenState createState() => _NewTweetScreenState();
}

class _NewTweetScreenState extends State<NewTweetScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            child: SizedBox(
              child: RoundedButton(
                label: 'Tweet',
                onPress: () {
                  print('New tweet');
                },
                disabled: true,
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
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.red,
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
                        maxLines: null,
                        maxLength: 140,
                        style: Theme.of(context).textTheme.body2,
                      ),
                      width: 335,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red,
              ),
              width: 30,
              height: 30,
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
