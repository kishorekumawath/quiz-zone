import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/Screens/question/answer_check_screen.dart';
import 'package:quiz_zone/config/theme/custom_text_styles.dart';
import 'package:quiz_zone/controllers/question_paper/question_controller_extension.dart';
import 'package:quiz_zone/controllers/question_paper/questions_controller.dart';
import 'package:quiz_zone/widgets/background_decoration.dart';
import 'package:quiz_zone/widgets/custom_app_bar.dart';

import '../../config/theme/app_colors.dart';
import '../../widgets/content_area.dart';
import '../../widgets/questions/answer_card.dart';
import '../../widgets/questions/question_num_card.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({super.key});

  static const String routeName = "/resultScreen";

  @override
  Widget build(BuildContext context) {
    Color _textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: BackGroundDecoration(
        appbar: CustomAppBar(
          leading: Text(''),
          title: controller.correctAnsweredQuestion,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: Get.height * 0.15, left: 10, right: 10),
          child: ContentArea(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset('assets/images/bulb.svg'),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Congratulations",
                  style: headerText.copyWith(
                    color: _textColor,
                  ),
                ),
              ),
              Text(
                "You have ${controller.points} points",
                style: TextStyle(color: _textColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Tap the below question to view correct answer',
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.allQuestion.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Get.width ~/ 75,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (_, index) {
                      final _question = controller.allQuestion[index];
                      AnswerStatus _status = AnswerStatus.notAnswer;
                      final _selectedAnswer = _question.selectedAnswer;
                      final _correctAnswer = _question.correctAnswer;
                      if (_selectedAnswer == _correctAnswer) {
                        _status = AnswerStatus.correct;
                      } else if (_selectedAnswer == null) {
                        _status = AnswerStatus.wrong;
                      } else {
                        _status = AnswerStatus.wrong;
                      }
                      return QuestionNumberCard(
                          index: index + 1,
                          status: _status,
                          onTap: () {
                            controller.jumpToQuestion(index, isGoBack: false);
                            // Get.toNamed(AnswerCheckScreen.routeName);
                          });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.tryAgain();
                    },
                    child: Container(
                      height: 55,
                      width: Get.width * 0.4,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Try again",
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? onSurfaceTextColor
                                  : Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.saveTestResult();
                    },
                    child: Container(
                      height: 55,
                      width: Get.width * 0.4,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Save test",
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? onSurfaceTextColor
                                  : Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  controller.navigateToHome();
                },
                child: Container(
                  height: 55,
                  width: Get.width,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Go to Home",
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? onSurfaceTextColor
                              : Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      )),
    );
  }
}

// class ResultScreen extends GetView<QuestionsController>{
//   const ResultScreen({super.key});
//   static const String routeName = "/resultScreen";
//
//   @override
//   Widget build(BuildContext context) {
//     Color _textColor = Get.isDarkMode?Colors.white:Theme.of(context).primaryColor;
//     return Scaffold(
//       body: BackGroundDecoration(
//         appbar: CustomAppBar(
//           leading: SizedBox(),
//           // title: controller.correctAnsweredQuestion,
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(top: Get.height*0.15,left: 10,right: 10),
//           child: Expanded(
//             child: ContentArea(child:
//             Column(
//               children: [
//                 SizedBox(height: 20,),
//
//                 SvgPicture.asset('assets/images/bulb.svg'),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20,bottom: 5),
//                   child: Text(
//                     "Congratulations",
//                     style: headerText.copyWith(
//                       color: _textColor,
//                     ),
//                   ),
//                 ),
//
//                 Text("You have ${controller.points} points",style: TextStyle(color: _textColor),),
//
//                 const SizedBox(height: 20,),
//                 Text('Tap the below question to view correct answer',textAlign: TextAlign.center,),
//                 const SizedBox(height: 20,),
//
//
//                 Expanded(
//                   child: GridView.builder(
//                       shrinkWrap: true,
//                       physics: BouncingScrollPhysics(),
//                       itemCount: controller.allQuestion.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: Get.width~/75,
//                         childAspectRatio: 1,
//                         crossAxisSpacing: 8,
//                         mainAxisSpacing: 8,
//                       ), itemBuilder: (_,index){
//                         final _question = controller.allQuestion[index];
//                         AnswerStatus _status = AnswerStatus.notAnswer;
//                           final _selectedAnswer = _question.selectedAnswer;
//                         final _correctAnswer = _question.correctAnswer;
//                         if(_selectedAnswer==_correctAnswer){
//                           _status = AnswerStatus.correct;
//                         }else if(_selectedAnswer==null){
//                           _status = AnswerStatus.wrong;
//                         }else{
//                           _status = AnswerStatus.wrong;
//                         }
//                     return QuestionNumberCard(
//                       index: index+1,
//                       status: _status,
//                       onTap: (){
//                           controller.jumpToQuestion(index,isGoBack: false);
//                           Get.toNamed(AnswerCheckScreen.routeName);
//                       }
//
//                     );
//                   }),
//                 ),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: (){
//                         controller.tryAgain();
//                       },
//                       child: Container(
//                         height: 55,
//                         width: Get.width*0.4,
//                         margin: EdgeInsets.only(bottom: 20),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Try again",
//                             style: TextStyle(color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,fontSize: 16,fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: (){
//                         controller.saveTestResult();
//                       },
//                       child: Container(
//                         height: 55,
//                         width: Get.width*0.4,
//                         margin: EdgeInsets.only(bottom: 20),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Go to home",
//                             style: TextStyle(color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,fontSize: 16,fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )
//             ),
//           ),
//         ),
//       )
//
//     );
//   }
// }
