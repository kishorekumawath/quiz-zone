import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_zone/config/theme/app_colors.dart';
import 'package:quiz_zone/config/theme/ui_parameters.dart';

enum AnswerStatus{
  correct,wrong,answered,notAnswer
}

class AnswerCard extends StatelessWidget {
  const AnswerCard({super.key, required this.answer,  this.isSelected = false, required this.onTap});
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameter.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Text(
          answer,
          style: TextStyle(
            color: isSelected?onSurfaceTextColor:null,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: UIParameter.cardBorderRadius,
          color: isSelected?answerSelectedColor():Theme.of(context).cardColor,
          border: Border.all(
            color: isSelected?answerSelectedColor():answerBorderColor(),
          )
        ),
      )
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: UIParameter.cardBorderRadius,
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Text(
            answer,
            style: TextStyle(
              color: correctAnswerColor,
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: UIParameter.cardBorderRadius,
              color: correctAnswerColor.withOpacity(0.2),
              border: Border.all(
                color:correctAnswerColor,
              )
          ),
        )
    );
  }
}

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: UIParameter.cardBorderRadius,
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Text(
            answer,
            style: TextStyle(
              color: wrongAnswerColor,
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: UIParameter.cardBorderRadius,
              color: wrongAnswerColor.withOpacity(0.2),
              border: Border.all(
                color:wrongAnswerColor,
              )
          ),
        )
    );
  }
}

class NotAnswer extends StatelessWidget {
  const NotAnswer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: UIParameter.cardBorderRadius,
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Text(
            answer,
            style: TextStyle(
              color: NotAnswerColor,
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: UIParameter.cardBorderRadius,
              color: NotAnswerColor.withOpacity(0.2),
              border: Border.all(
                color:NotAnswerColor,
              )
          ),
        )
    );
  }
}



