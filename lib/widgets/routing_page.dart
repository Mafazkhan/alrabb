import 'package:flutter/material.dart';

class RoutingPage {
  static goToNext({required Widget widget, required BuildContext context}) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));
  }
}
