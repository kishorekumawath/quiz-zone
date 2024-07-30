//in dart u can inherit the class with only one class so we don't have option to inherit with multiple class so to solve this we use the mixin
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_zone/config/theme/app_colors.dart';

mixin SubThemeData {
  TextTheme getTextTheme() {
    return GoogleFonts.quicksandTextTheme(TextTheme(
      bodyLarge: TextStyle(fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontWeight: FontWeight.w400),
    ));
  }

  IconThemeData getIconTheme(){
    return const IconThemeData(
      color: onSurfaceTextColor,
      size: 16,
    );
  }
}
