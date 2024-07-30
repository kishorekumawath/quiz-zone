import 'package:flutter/material.dart';
import 'package:quiz_zone/config/theme/custom_text_styles.dart';

class CountDownTimer extends StatelessWidget {
  const CountDownTimer({super.key, this.color, required this.time});
  final Color? color;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.timer,color: color??Colors.white,),
        SizedBox(width: 5,),
        Text(time,style: TextStyle(color: color??Colors.white,),)
      ],
    );
  }
}
