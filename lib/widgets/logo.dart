// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final double height;
  final double width;

  Logo({
    this.height = 50,
    this.width = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/twitter-logo.svg',
      height: this.height,
      semanticsLabel: 'Logo',
      width: this.width,
    );
  }
}
