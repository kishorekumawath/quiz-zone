import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_zone/config/theme/app_colors.dart';
import 'package:quiz_zone/config/theme/ui_parameters.dart';

TextStyle cardTitles(context)=>TextStyle(
  color: UIParameter.isDarkMode()?Theme.of(context).textTheme.bodyLarge!.color:
  Theme.of(context).primaryColor,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const questionTS = TextStyle(fontSize: 16,fontWeight: FontWeight.w800,);
const detailText = TextStyle(fontSize: 12);
const headerText = TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: onSurfaceTextColor);
const appbarTS = TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: onSurfaceTextColor);