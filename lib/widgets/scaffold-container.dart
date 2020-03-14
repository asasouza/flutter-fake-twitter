// flutter
import 'package:flutter/material.dart';
// helpers
import '../helpers/colors.dart';

class ScaffoldContainer extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final bool topDivider;

  ScaffoldContainer({
    this.appBar,
    @required this.body,
    this.topDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.appBar,
      backgroundColor: this.appBar != null ? ColorsHelper.lightGray : Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          child: this.body,
          color: Theme.of(context).primaryColor,
          margin: this.topDivider && this.appBar != null ? EdgeInsets.only(top: 0.5) : null,
          width: double.infinity,
        ),
      ),
    );
  }
}
