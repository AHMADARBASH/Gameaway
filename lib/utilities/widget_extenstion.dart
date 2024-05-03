import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter/material.dart';

extension WidgetExtenstion on Widget {
  //bounce the widget when pressed
  Widget bounce(
      {required void Function() onPressed, required Duration duration}) {
    return Bounce(onPressed: onPressed, duration: duration, child: this);
  }
}
