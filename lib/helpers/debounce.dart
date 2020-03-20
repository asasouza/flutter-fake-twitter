import 'package:flutter/foundation.dart';
import 'dart:async';

class DebounceHelper {
  Timer _timer;

  void run(int duration, VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: duration), action);
  }
}