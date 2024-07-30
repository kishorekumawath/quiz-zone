import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/Screens/question/test_overview_screen.dart';
import 'package:quiz_zone/config/theme/custom_text_styles.dart';
import 'package:quiz_zone/controllers/question_paper/questions_controller.dart';
import 'package:quiz_zone/firebase_ref/loading_status.dart';
import 'package:quiz_zone/widgets/background_decoration.dart';
import 'package:quiz_zone/widgets/content_area.dart';
import 'package:quiz_zone/widgets/custom_app_bar.dart';
import 'package:quiz_zone/widgets/questions/answer_card.dart';
import 'package:quiz_zone/widgets/questions/countdown_timer.dart';

import '../../config/theme/app_colors.dart';
import '../../widgets/question_place_holder.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({super.key});

  static const String routeName = '/questionScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundDecoration(
          appbar: CustomAppBar(
            leading: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: ShapeDecoration(
                  shape: StadiumBorder(
                      side: BorderSide(color: onSurfaceTextColor, width: 2))),
              child: Obx(
                () => CountDownTimer(time: controller.time.value),
              ),
            ),
            showActionIcon: true,
            onMenuActionTap: () {
              Get.toNamed(TextOverviewScreen.routeName);
            },
            titleWidget: Obx(()=>Text(
              controller.loadingStatus.value == LoadingStatus.completed
                ?"Q. ${(controller.questionIndex.toInt()+1).toString().padLeft(2,'0')}":"",style: appbarTS,),)

          ),
          child: Obx(
            () => controller.loadingStatus.value == LoadingStatus.loading
                ? Padding(
                    padding: EdgeInsets.only(
                        top: Get.height * 0.15, left: 10, right: 10),
                    child: ContentArea(child: questionScreenHolder()),
                  )
                : Column(
                  children: [
                    Expanded(
                      child: Padding(
                      padding: EdgeInsets.only(top: Get.height*0.15,left: 10,right: 10),
                      child: ContentArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Text(controller.currentQuestion.value!.question,style: questionTS,),
                              GetBuilder<QuestionsController>(
                                  id: 'answer_list',// by setting the id we can update the ui based on id name
                                  builder: (context){
                                return ListView.separated(
                                  shrinkWrap: true,
                                    itemBuilder: (BuildContext context,int index ){
                                      final answer = controller.currentQuestion.value!.answers[index];
                                      return AnswerCard(answer: "${answer.identifier}. ${answer.answer}", onTap: (){
                                        controller.selectedAnswer(answer.identifier,);
                                      },isSelected: answer.identifier == controller.currentQuestion.value!.selectedAnswer,
                                      );
                                    },
                                    separatorBuilder: (BuildContext context,int index)=>SizedBox(height: 20,),
                                    itemCount: controller.currentQuestion.value!.answers.length);
                              }),
                            ],
                          ),
                        ),
                      ),
                                    ),
                    ),

      Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ColoredBox(
                color: customScaffoldColor(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Visibility(
                        visible: controller.isFirstQuestion,
                        child: GestureDetector(
                          onTap: ()=>controller.prevQuestion(),
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(Icons.arrow_back_ios_new_rounded,color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,),
                          ),
                        ),
                      ),
                      Expanded(child: GestureDetector(
                        onTap: (){
                          if(controller.isLastQuestion){
                            Get.toNamed(TextOverviewScreen.routeName);
                          }else{
                          controller.nextQuestion();
                          }
                        },
                        child: Visibility(
                          visible: controller.loadingStatus.value == LoadingStatus.completed,
                          child: Container(
                            height: 55,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                controller.isLastQuestion?"Complete":
                                "Next",
                                style: TextStyle(color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,fontSize: 16,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )),

                    ],
                  ),
                ),
              ),
            ),

                  ],
                ),
          )),
    );
  }
}

// class QuestionsScreen extends GetView<QuestionsController> {
//   const QuestionsScreen({super.key});
//
//   static const String routeName = '/questionScreen';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BackGroundDecoration(
//         appbar: CustomAppBar(
//           leading: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
//             decoration: ShapeDecoration(
//               shape: StadiumBorder(
//                 side: BorderSide(color: onSurfaceTextColor,width: 2)
//               )
//             ),
//             child:Obx(()=>CountDownTimer(time: controller.time.value),),
//           ),
//           showActionIcon: true,
//           onMenuActionTap: (){
//             Get.toNamed(TextOverviewScreen.routeName);
//           },
//           titleWidget: Obx(()=>Text("Q. ${(controller.questionIndex.value+1).toString().padLeft(2,'0')}",style: appbarTS,),)
//         ),
//         child: Obx(()=>Column(
//           children: [
//             if(controller.loadingStatus.value == LoadingStatus.loading)
//               Expanded(child: Padding(
//                 padding: EdgeInsets.only(top: Get.height*0.15,left: 10,right: 10),
//                 child: ContentArea(child: questionScreenHolder()),
//               )),
//             if(controller.loadingStatus.value==LoadingStatus.completed)
//               Expanded(child: Padding(
//                 padding: EdgeInsets.only(top: Get.height*0.15,left: 10,right: 10),
//                 child: ContentArea(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 20,),
//                         Text(controller.currentQuestion.value!.question,style: questionTS,),
//                         GetBuilder<QuestionsController>(
//                             id: 'answer_list',// by setting the id we can update the ui based on id name
//                             builder: (context){
//                           return ListView.separated(
//                             shrinkWrap: true,
//                               itemBuilder: (BuildContext context,int index ){
//                                 final answer = controller.currentQuestion.value!.answers[index];
//                                 return AnswerCard(answer: "${answer.identifier}. ${answer.answer}", onTap: (){
//                                   controller.selectedAnswer(answer.identifier,);
//                                 },isSelected: answer.identifier == controller.currentQuestion.value!.selectedAnswer,
//                                 );
//                               },
//                               separatorBuilder: (BuildContext context,int index)=>SizedBox(height: 20,),
//                               itemCount: controller.currentQuestion.value!.answers.length);
//                         }),
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: ColoredBox(
//                 color: customScaffoldColor(),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Row(
//                     children: [
//                       Visibility(
//                         visible: controller.isFirstQuestion,
//                         child: GestureDetector(
//                           onTap: ()=>controller.prevQuestion(),
//                           child: Container(
//                             height: 55,
//                             width: 55,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10)
//                             ),
//                             child: Icon(Icons.arrow_back_ios_new_rounded,color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,),
//                           ),
//                         ),
//                       ),
//                       Expanded(child: GestureDetector(
//                         onTap: (){
//                           if(controller.isLastQuestion){
//                             Get.toNamed(TextOverviewScreen.routeName);
//                           }else{
//                           controller.nextQuestion();
//                           }
//                         },
//                         child: Visibility(
//                           visible: controller.loadingStatus.value == LoadingStatus.completed,
//                           child: Container(
//                             height: 55,
//                             margin: EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10)
//                             ),
//                             child: Center(
//                               child: Text(
//                                 controller.isLastQuestion?"Complete":
//                                 "Next",
//                                 style: TextStyle(color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,fontSize: 16,fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//
//         ),)
//       ),
//     );
//   }
// }
