// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz_zone/controllers/question_paper/questions_controller.dart';
//
// import '../../config/theme/app_colors.dart';
// import '../../config/theme/custom_text_styles.dart';
// import '../../widgets/background_decoration.dart';
// import '../../widgets/content_area.dart';
// import '../../widgets/custom_app_bar.dart';
// import '../../widgets/questions/answer_card.dart';
//
// class AnswerCheckScreen extends GetView<QuestionsController> {
//   const AnswerCheckScreen({super.key});
//
//   static const String routeName ='/answerCheckScreen';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  BackGroundDecoration(
//           appbar: CustomAppBar(
//               showActionIcon: true,
//               onMenuActionTap: (){
//                 // Get.toNamed(TextOverviewScreen.routeName);
//               },
//               titleWidget: Obx(()=>Text("Q. ${(controller.questionIndex.value+1).toString().padLeft(2,'0')}",style: appbarTS,),)
//           ),
//           child: Obx(()=>Column(
//             children: [
//                 Expanded(child: Padding(
//                   padding: EdgeInsets.only(top: Get.height*0.15,left: 10,right: 10),
//                   child: ContentArea(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           SizedBox(height: 20,),
//                           Text(controller.currentQuestion.value!.question,style: questionTS,),
//                           GetBuilder<QuestionsController>(
//                             id: "answer_review_list",
//                               builder: (context){
//                                 return ListView.separated(
//                                     shrinkWrap: true,
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     itemBuilder: (_,int index ){
//                                       final answer = controller.currentQuestion.value!.answers[index];
//                                       final selectedAnswer = controller.currentQuestion.value!.selectedAnswer;
//                                       final correctAnswer = controller.currentQuestion.value!.correctAnswer;
//
//                                       final String answerText = "${answer.identifier}. ${answer.answer}";
//
//                                       if(correctAnswer == selectedAnswer &&answer.identifier == selectedAnswer){
//                                         // correct answer
//                                         return CorrectAnswer(answer: answerText);
//                                       }else if (correctAnswer == answer.identifier){
//                                         // correct answer
//                                         return CorrectAnswer(answer: answerText);
//                                       }
//                                       else if(correctAnswer != selectedAnswer && answer.identifier == selectedAnswer){
//                                         // wrong answer
//                                         return WrongAnswer(answer: answerText);
//                                       }else if(selectedAnswer == null){
//                                         return NotAnswer(answer: answerText);
//                                       }
//
//                                       return AnswerCard(
//                                         answer: answerText,
//                                         onTap: (){
//
//                                       },
//                                         isSelected: false,
//                                       );
//                                     },
//                                     separatorBuilder: (_,int index)=>SizedBox(height: 20,),
//                                     itemCount: controller.currentQuestion.value!.answers.length);
//                               }),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )),
//               // Padding(
//               //   padding: EdgeInsets.symmetric(horizontal: 10),
//               //   child: ColoredBox(
//               //     color: customScaffoldColor(),
//               //     child: Padding(
//               //       padding: const EdgeInsets.all(20),
//               //       child: Row(
//               //         children: [
//               //           Visibility(
//               //             visible: controller.isFirstQuestion,
//               //             child: GestureDetector(
//               //               onTap: ()=>controller.prevQuestion(),
//               //               child: Container(
//               //                 height: 55,
//               //                 width: 55,
//               //                 decoration: BoxDecoration(
//               //                     color: Colors.white,
//               //                     borderRadius: BorderRadius.circular(10)
//               //                 ),
//               //                 child: Icon(Icons.arrow_back_ios_new_rounded,color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,),
//               //               ),
//               //             ),
//               //           ),
//               //           Expanded(child: GestureDetector(
//               //             onTap: (){
//               //               if(controller.isLastQuestion){
//               //                 Get.toNamed(TextOverviewScreen.routeName);
//               //               }else{
//               //                 controller.nextQuestion();
//               //               }
//               //             },
//               //             child: Visibility(
//               //               visible: controller.loadingStatus.value == LoadingStatus.completed,
//               //               child: Container(
//               //                 height: 55,
//               //                 margin: EdgeInsets.only(left: 10),
//               //                 decoration: BoxDecoration(
//               //                     color: Colors.white,
//               //                     borderRadius: BorderRadius.circular(10)
//               //                 ),
//               //                 child: Center(
//               //                   child: Text(
//               //                     controller.isLastQuestion?"Complete":
//               //                     "Next",
//               //                     style: TextStyle(color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,fontSize: 16,fontWeight: FontWeight.bold),
//               //                   ),
//               //                 ),
//               //               ),
//               //             ),
//               //           )),
//               //
//               //         ],
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//
//           ),)
//       ),
//     );
//   }
// }
