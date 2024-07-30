import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/config/theme/app_icons.dart';
import 'package:quiz_zone/config/theme/custom_text_styles.dart';
import 'package:quiz_zone/config/theme/ui_parameters.dart';
import 'package:quiz_zone/controllers/question_paper/question_paper_controller.dart';
import 'package:quiz_zone/models/question_paper_model.dart';
import 'package:quiz_zone/widgets/app_icon_text.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  const QuestionCard({super.key, required this.model});

  final QuestionPaperModel model;

  @override
  Widget build(BuildContext context) {
    const _padding = 10.0;
    return InkWell(
      onTap: (){
        // controller.navigateToQuestion(paper: model,tryAgain: false);
        },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: UIParameter.cardBorderRadius,
          color: Theme.of(context).cardColor,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(_padding),
              child: Row(
                crossAxisAlignment:  CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: UIParameter.cardBorderRadius,
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        height: Get.width*0.16,
                        width: Get.width*0.16,
                        child: CachedNetworkImage(
                          imageUrl: model.imageUrl!,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/app_splash_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.title,
                          style: cardTitles(context)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Text(model.description),
                        ),
                        Row(
                          children: [
                            AppIconText(
                                icon: Icon(Icons.help_outline_sharp,
                                  color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor,),
                                text: Text(
                                    '${model.questionCount} question',
                                  style: detailText.copyWith(
                                    color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor,
                                  ),
                                ),

                            ),

                            SizedBox(width: 15,),

                            AppIconText(
                              icon: Icon(Icons.timer,
                                color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor,),
                              text: Text(
                                model.timeInMints(),
                                style: detailText.copyWith(
                                  color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor,
                                ),
                              ),

                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(cardBorderRadius),bottomRight: Radius.circular(cardBorderRadius)),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Icon(AppIcons.trophyOutline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
