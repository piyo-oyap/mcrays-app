import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GuiHelper {
  static void showSnackBar(BuildContext context, String str) {
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

  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
    );
  }
}