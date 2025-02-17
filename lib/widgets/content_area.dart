import 'package:flutter/material.dart';
import 'package:quiz_zone/config/theme/app_colors.dart';
import 'package:quiz_zone/config/theme/ui_parameters.dart';

class ContentArea extends StatelessWidget {
  final bool addPadding;
  final Widget child;
  const ContentArea({super.key,  this.addPadding = true,required this.child,});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: customScaffoldColor(),
        ),
        padding: addPadding?EdgeInsets.only(left: mobileScreenPadding,right: mobileScreenPadding):null,
        child: child,
      ),
    );
  }
}
