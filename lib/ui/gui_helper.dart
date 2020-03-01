import 'package:flutter/material.dart';

class GuiHelper {
  static showSnackBar(BuildContext context, String str) {
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(str)));
  }

  static double calculateHeightProportionalToScreen(BuildContext context, double percentage) {
    assert(percentage >= 0 && percentage <= 1);
    return MediaQuery.of(context).size.height * percentage;
  }

  static double calculateWidthProportionalToScreen(BuildContext context, double percentage) {
    assert(percentage >= 0 && percentage <= 1);
    return MediaQuery.of(context).size.width * percentage;
  }
}