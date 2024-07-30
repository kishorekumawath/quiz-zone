import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/config/theme/app_dark_theme.dart';
import 'package:quiz_zone/config/theme/app_light_theme.dart';
import 'package:quiz_zone/config/theme/ui_parameters.dart';

const onSurfaceTextColor = Colors.white;
const correctAnswerColor = Color(0xFF3ac3cb);
const wrongAnswerColor = Color(0xFFf85187);
const NotAnswerColor = Color(0xFF2a3c65);


const mainGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLightColorLight, primaryColorLight]);

const mainGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDarkColorDark, primaryColorDark]);

LinearGradient mainGradient()=>
    UIParameter.isDarkMode()?mainGradientDark:mainGradientLight;

Color customScaffoldColor()=>
    UIParameter.isDarkMode()?const Color(0xFF2e3c62)
        :const Color.fromARGB(255, 240, 237, 255);

Color answerSelectedColor()=>UIParameter.isDarkMode()?Theme.of(Get.context!).cardColor.withOpacity(0.5):
    Theme.of(Get.context!).primaryColor;

Color answerBorderColor()=>UIParameter.isDarkMode()?Color.fromARGB(255,26, 46, 158):
Color.fromARGB(255,221, 221,221 );