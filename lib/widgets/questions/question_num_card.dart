import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/config/theme/app_colors.dart';
import 'package:quiz_zone/config/theme/ui_parameters.dart';
import 'package:quiz_zone/widgets/questions/answer_card.dart';

class QuestionNumberCard extends StatelessWidget {
  const QuestionNumberCard({super.key, required this.index, this.status, required this.onTap});

  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    Color _bgColor = Theme.of(context).primaryColor;

    switch(status){
      case AnswerStatus.answered:
        _bgColor = UIParameter.isDarkMode()?Theme.of(context).cardColor:Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
        _bgColor = correctAnswerColor;
        break;
      case AnswerStatus.wrong:
        _bgColor = wrongAnswerColor;
        break;
      case AnswerStatus.notAnswer:
        _bgColor =Get.isDarkMode?Colors.red.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1);
        break;

      default:
        _bgColor = Theme.of(context).primaryColor.withOpacity(0.1);

    }

    return InkWell(
      borderRadius: UIParameter.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        child: Center(
          child: Text(
            "$index",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _bgColor,
          borderRadius: UIParameter.cardBorderRadius
        ),
      ),
    );
  }
}
