import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/config/theme/custom_text_styles.dart';
import 'package:quiz_zone/config/theme/ui_parameters.dart';
import 'package:quiz_zone/controllers/question_paper/questions_controller.dart';
import 'package:quiz_zone/widgets/background_decoration.dart';
import 'package:quiz_zone/widgets/content_area.dart';
import 'package:quiz_zone/widgets/custom_app_bar.dart';
import 'package:quiz_zone/widgets/questions/answer_card.dart';
import 'package:quiz_zone/widgets/questions/countdown_timer.dart';
import 'package:quiz_zone/widgets/questions/question_num_card.dart';

import '../../config/theme/app_colors.dart';

class TextOverviewScreen extends GetView<QuestionsController> {
  const TextOverviewScreen({super.key});
  static const String routeName ="/testOverviewScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundDecoration(
        appbar: CustomAppBar(
          title: controller.completeTest,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: Get.height*0.15,left: 10,right: 10),
          child: ContentArea(child:
            Column(
              children: [
                const SizedBox(height: 20,),
                Row(
                  children: [
                    CountDownTimer(
                        color: UIParameter.isDarkMode()?Theme.of(context).textTheme.bodyLarge!.color:
                        Theme.of(context).primaryColor,
                        time: ''),
                    Obx(() => Text('${controller.time} Remaining',style: appbarTS.copyWith(color: UIParameter.isDarkMode()?Theme.of(context).textTheme.bodyLarge!.color:
                    Theme.of(context).primaryColor,),)),
                  ],
                ),

                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.allQuestion.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Get.width~/75,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ), itemBuilder: (_,index){

                      AnswerStatus? answerStatus;
                      if(controller.allQuestion[index].selectedAnswer!=null){
                        answerStatus = AnswerStatus.answered;
                      }
                        return QuestionNumberCard(
                          index: index+1,
                          status: answerStatus,
                          onTap: ()=>controller.jumpToQuestion(index),

                        );
                  }),
                ),

                GestureDetector(
                  onTap: (){
                    controller.submit();
                  },
                  child: Container(
                    height: 55,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}

// class TextOverviewScreen extends GetView<QuestionsController> {
//   const TextOverviewScreen({super.key});
//   static const String routeName ="/testOverviewScreen";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BackGroundDecoration(
//         appbar: CustomAppBar(
//           title: controller.completeTest,
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(top: Get.height*0.15,left: 10,right: 10),
//           child: Expanded(
//             child: ContentArea(child:
//               Column(
//                 children: [
//                   SizedBox(height: 20,),
//                   Row(
//                     children: [
//                       CountDownTimer(
//                           color: UIParameter.isDarkMode()?Theme.of(context).textTheme.bodyLarge!.color:
//                           Theme.of(context).primaryColor,
//                           time: ''),
//                       Obx(() => Text('${controller.time} Remaining',style: appbarTS.copyWith(color: UIParameter.isDarkMode()?Theme.of(context).textTheme.bodyLarge!.color:
//                       Theme.of(context).primaryColor,),)),
//                     ],
//                   ),
//
//                   Expanded(
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                         physics: BouncingScrollPhysics(),
//                         itemCount: controller.allQuestion.length,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: Get.width~/75,
//                           childAspectRatio: 1,
//                           crossAxisSpacing: 8,
//                           mainAxisSpacing: 8,
//                         ), itemBuilder: (_,index){
//
//                         AnswerStatus? answerStatus;
//                         if(controller.allQuestion[index].selectedAnswer!=null){
//                           answerStatus = AnswerStatus.answered;
//                         }
//                           return QuestionNumberCard(
//                             index: index+1,
//                             status: answerStatus,
//                             onTap: ()=>controller.jumpToQuestion(index),
//
//                           );
//                     }),
//                   ),
//
//                   GestureDetector(
//                     onTap: (){
//                       controller.submit();
//                     },
//                     child: Container(
//                       height: 55,
//                       margin: EdgeInsets.only(bottom: 20),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Submit",
//                           style: TextStyle(color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,fontSize: 16,fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
