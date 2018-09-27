import 'dart:ui';

import 'package:flutter/material.dart';

class ViewUtil {
  static bool getValueCheck(bool isChecked) {
    return !isChecked;
  }

  static Color getColorCheckButton(bool isChecked) {
    if (isChecked) return Colors.blue;
    return Colors.grey;
  }
}
