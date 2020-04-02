import 'package:flutter/material.dart';

class ButtonRounded extends StatelessWidget {
  final bool disabled;
  final bool isLoading;
  final String label;
  final Function onPress;

  ButtonRounded({
    this.disabled = false,
    this.isLoading = false,
    @required this.label,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        child: this.isLoading
            ? SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                width: 17,
                height: 17,
              )
            : Text(
                this.label,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: this.disabled
                      ? Colors.white.withOpacity(0.6)
                      : Colors.white,
                ),
              ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: this.disabled
              ? Theme.of(context).accentColor.withOpacity(0.8)
              : Theme.of(context).accentColor,
        ),
        padding: EdgeInsets.all(7),
      ),
      onTap: this.disabled || this.isLoading ? () {} : this.onPress,
    );
  }
}
