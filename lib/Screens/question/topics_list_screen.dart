import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/Screens/question/question_screen.dart';
import 'package:quiz_zone/controllers/question_paper/topic_list_controller.dart';
import 'package:quiz_zone/widgets/background_decoration.dart';
import 'package:quiz_zone/widgets/content_area.dart';
import 'package:quiz_zone/widgets/custom_app_bar.dart';
import 'package:quiz_zone/widgets/questions/topic_card.dart';
import 'package:quiz_zone/widgets/topic_list_holder.dart';

import '../../firebase_ref/loading_status.dart';
import '../../widgets/question_place_holder.dart';

class TopicsListScreen extends GetView<TopicsListController> {
  const TopicsListScreen({super.key});

  static const String routeName = "/topicsList";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackGroundDecoration(
      appbar: Obx(
        () => CustomAppBar(
          title: controller.loadingStatus.value == LoadingStatus.completed
              ? controller.subjectTitle
              : "",
        ),
      ),
      child: Obx(
        () => controller.loadingStatus.value == LoadingStatus.loading
            ? Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.15, left: 10, right: 10),
            child: const ContentArea(child: TopicListHolder()),
                          )
            :Padding(
          padding: EdgeInsets.only(
              top: Get.height * 0.15, left: 10, right: 10),
          child: ContentArea(
            child: ListView.separated(
                itemBuilder: (BuildContext context,int index){
                  return TopicCard(title: controller.topicName(index),
                      questionsCount: controller.questionCount(index).toString(),
                      time: controller.subjectPaperModel.topics![index].timeInMints(),
                      onTap: (){
                    Get.toNamed(QuestionsScreen.routeName,arguments: {
                      "subjectID":controller.subjectPaperModel.id,
                          "topicsData": controller.subjectPaperModel.topics![index]
                          });
                  });
                },
                separatorBuilder: (BuildContext context,int index)=>const SizedBox(height: 10,),
                itemCount:controller.topicsCount,
            ),
          ),
        )
      ),
    ));
  }
}
