// flutter
import 'package:flutter/material.dart';
// helpers
import '../helpers/colors.dart';

class IconButton extends StatelessWidget {
  final Color color;
  final Widget icon;
  final Function onPress;
  final String text;

  IconButton({
    this.color,
    @required this.icon,
    @required this.onPress,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: GestureDetector(
            child: this.icon,
            onTap: this.onPress,
          ),
          padding: EdgeInsets.only(
            top: 5,
            right: 5,
            bottom: 5,
          ),
        ),
        Container(
          child: Text(
            this.text,
            style: Theme.of(context).textTheme.display3.merge(
                  TextStyle(
                    fontSize: 13,
                    color: this.color
                  ),
                ),
          ),
          margin: EdgeInsets.only(top: 2, right: 15),
          constraints: BoxConstraints(minWidth: 10),
        )
      ],
    );
  }
}
