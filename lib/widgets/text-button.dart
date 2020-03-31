// flutter
import 'package:flutter/material.dart';
// helper
import '../helpers/colors.dart';

class TextButton extends StatelessWidget {
  final bool disabled;
  final String label;
  final Function onPress;

  TextButton({
    this.disabled = false,
    @required this.label,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        this.label,
        style: TextStyle(
          fontSize: 14,
          color: this.disabled
              ? ColorsHelper.lightBlue.shade600
              : ColorsHelper.lightBlue,
          fontFamily: 'Roboto',
        ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: this.disabled ? () {} : this.onPress,
      padding: EdgeInsets.zero,
    );
  }
}
