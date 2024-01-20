import 'package:flutter/material.dart';

class AppTextStyle {

  static TextStyle textStyle({double fontSize = 14, FontWeight fontWeight = FontWeight.normal, Color fontColor = Colors.black}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: fontColor,
    );
  }
}