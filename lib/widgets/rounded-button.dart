import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final bool disabled;
  final bool isLoading;
  final String label;
  final Function onPress;
  final bool outline;
  final double padding;

  RoundedButton({
    this.disabled = false,
    this.isLoading = false,
    @required this.label,
    this.onPress,
    this.outline = false,
    this.padding = 7,
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
                  color: this.outline
                      ? Theme.of(context).accentColor
                      : (this.disabled
                          ? Colors.white.withOpacity(0.6)
                          : Colors.white),
                ),
              ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          border: this.outline
              ? Border.all(color: Theme.of(context).accentColor, width: 2)
              : null,
          color: this.outline
              ? Colors.transparent
              : (this.disabled
                  ? Theme.of(context).accentColor.withOpacity(0.8)
                  : Theme.of(context).accentColor),
        ),
        padding: EdgeInsets.all(this.padding),
      ),
      onTap: this.disabled || this.isLoading
          ? () {}
          : Feedback.wrapForTap(this.onPress, context),
    );
  }
}
