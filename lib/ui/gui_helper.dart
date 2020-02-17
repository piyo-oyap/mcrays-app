import 'package:flutter/material.dart';

class GuiHelper {
  static showSnackBar(BuildContext context, String str) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(str)));
  }
}