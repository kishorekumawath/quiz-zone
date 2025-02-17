import 'package:flutter/cupertino.dart';

class AppIcons{
  // create a singleton that means only one instance
  AppIcons._(); // private constructor
  static const fontFam = 'AppIcons';
  static const IconData trophyOutline = IconData(0xe808,fontFamily: fontFam);
  static const IconData menuLeft = IconData(0xe805,fontFamily: fontFam);
  static const IconData peace = IconData(0xe806,fontFamily: fontFam);
  static const IconData menu = IconData(0xe804,fontFamily: fontFam);
}