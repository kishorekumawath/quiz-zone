import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/config/theme/app_colors.dart';
import 'package:quiz_zone/config/theme/app_icons.dart';
import 'package:quiz_zone/config/theme/custom_text_styles.dart';
import 'package:quiz_zone/config/theme/ui_parameters.dart';
import 'package:quiz_zone/widgets/app_icon_text.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({super.key, required this.title, required this.onTap, required this.questionsCount, required this.time});

  final String title;
  final String questionsCount;
  final String time;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(cardBorderRadius),
      onTap: onTap,
      child: Ink(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title.capitalize!,style: detailText.copyWith(fontSize: 18,color: Get.isDarkMode?Colors.white:Colors.black),),
                SizedBox(height: 5,),
                Row(
                  children: [
                    AppIconText(icon: Icon(Icons.help_outline_sharp,size:Get.width*0.04,color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,), text: Text('$questionsCount questions',style: detailText.copyWith(fontSize: 14,color:Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,))),
                    SizedBox(width: 10,),
                    AppIconText(icon: Icon(Icons.timer,size:Get.width*0.03,color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,), text: Text(time,style: detailText.copyWith(fontSize: 14,color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,))),
                  ],
                )
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded,color: Theme.of(context).primaryColor,)

          ],
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Get.isDarkMode?Colors.white.withOpacity(0.2):Colors.black.withOpacity(0.2),),
          borderRadius: BorderRadius.circular(cardBorderRadius),
          color: Colors.white
        ),
      ),
    );
  }
}
