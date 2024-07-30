import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/config/theme/app_icons.dart';
import 'package:quiz_zone/config/theme/custom_text_styles.dart';
import 'package:quiz_zone/widgets/app_circle_btn.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.titleWidget,
      this.leading,
      this.showActionIcon = false,
      this.onMenuActionTap});

  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 40,
      width: Get.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: titleWidget == null
                ? Center(
                    child: Text(
                      title,
                      style: appbarTS,
                    ),
                  )
                : Center(child: titleWidget),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(-10,0),
                child: leading ??
                    BackButton(),
              ),
              if (showActionIcon)
                AppCircleBtn(
                  child: const Icon(AppIcons.menu),
                  onTap: onMenuActionTap??null,
                )
            ],
          )
        ],
      ),
    );
  }

}
