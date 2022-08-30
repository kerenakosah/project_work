import 'package:flutter/material.dart';

class HelperFunctions {
  // initialize the firebase user
  // hide all keyboard
  static void unFocus(BuildContext context, dynamic currentFocus) {
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      // use the focus manager to unFocus
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
