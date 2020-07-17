// flutter
import 'package:flutter/material.dart';

class BounceIcon extends StatefulWidget {
  final Icon _icon;

  BounceIcon(this._icon);

  @override
  _BounceIconState createState() => _BounceIconState();
}

class _BounceIconState extends State<BounceIcon> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.1, end: 1);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      child: widget._icon,
      scale: _tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.elasticOut,
        ),
      ),
    );
  }
}
