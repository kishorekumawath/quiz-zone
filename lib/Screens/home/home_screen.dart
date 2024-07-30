import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/Screens/home/menu_screen.dart';
import 'package:quiz_zone/Screens/home/question_card.dart';
import 'package:quiz_zone/Screens/home/subject_card.dart';
import 'package:quiz_zone/config/theme/app_colors.dart';
import 'package:quiz_zone/config/theme/app_icons.dart';
import 'package:quiz_zone/config/theme/custom_text_styles.dart';
import 'package:quiz_zone/config/theme/ui_parameters.dart';
import 'package:quiz_zone/controllers/question_paper/question_paper_controller.dart';
import 'package:quiz_zone/controllers/zoom_drawer_controller.dart';
import 'package:quiz_zone/firebase_ref/loading_status.dart';
import 'package:quiz_zone/models/questionPaperModel.dart';
import 'package:quiz_zone/widgets/app_circle_btn.dart';
import 'package:quiz_zone/widgets/content_area.dart';
import 'package:quiz_zone/widgets/home_paper_holder.dart';


// here we are using the get view because we can access the methods and properties without creating the instance of the controller
class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    // QuestionPaperController _questionPaperController = Get.find();
    QuestionPaperController _subjectPaperController = Get.find();
    return Scaffold(
          body: GetBuilder<MyZoomDrawerController>(builder: (_){
            return ZoomDrawer(
              borderRadius: 50,
              controller: _.zoomDrawerController,
              showShadow: true,
              angle: 0.0,
              menuBackgroundColor: Theme.of(context).primaryColorLight,
              slideWidth: MediaQuery.of(context).size.width * 0.65,
              style: DrawerStyle.defaultStyle,
              menuScreen: const MyMenuScreen(),
              mainScreen: Container(
                decoration: BoxDecoration(
                    gradient: mainGradient()
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // header content area
                      Padding(
                        padding: EdgeInsets.all(mobileScreenPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.translate(
                              offset: const Offset(-14,0),
                              child: IconButton(
                                icon: const Icon(AppIcons.menuLeft,),
                                onPressed: controller.toggleDrawer,
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Icon(AppIcons.peace),
                                  SizedBox(width: 5,),
                                  Text("Hello Friends",style:  detailText.copyWith(color: onSurfaceTextColor,fontWeight: FontWeight.w700,),),
                                ],
                              ),
                            ),
                            const Text("What do you want to learn today?",style: headerText,)
                          ],
                        ),
                      ),

                      // content area section
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ContentArea(
                            child: Obx(() =>_subjectPaperController.loadingData==LoadingStatus.completed? ListView.separated(
                              physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  // return QuestionCard(model: _questionPaperController.allPaper[index]);
                                  return SubjectCard(subject: _subjectPaperController.allSubjects[index]);
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 1,
                                  );
                                },
                                // itemCount: _questionPaperController.allPaper.length
                                itemCount: _subjectPaperController.allSubjects.length,
                            ):const HomePaperHolder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },)
        );
  }
}


// previous home screen
// return Scaffold(
//   body: GetBuilder<MyZoomDrawerController>(builder: (_){
//     return ZoomDrawer(
//       borderRadius: 50,
//       controller: _.zoomDrawerController,
//       showShadow: true,
//       angle: 0.0,
//       menuBackgroundColor: Theme.of(context).primaryColorLight,
//       slideWidth: MediaQuery.of(context).size.width * 0.65,
//       style: DrawerStyle.defaultStyle,
//       menuScreen: MyMenuScreen(),
//       mainScreen: Container(
//         decoration: BoxDecoration(
//             gradient: mainGradient()
//         ),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               // header content area
//               Padding(
//                 padding: EdgeInsets.all(mobileScreenPadding),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     IconButton(
//                       icon: Icon(AppIcons.menuLeft,),
//                       onPressed: controller.toggleDrawer,
//                     ),
//                     SizedBox(height: 10,),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Row(
//                         children: [
//                           Icon(AppIcons.peace),
//                           Text("Hello Friends",style:  detailText.copyWith(color: onSurfaceTextColor),),
//                         ],
//                       ),
//                     ),
//                     Text("What do you want to learn today?",style: headerText,)
//                   ],
//                 ),
//               ),
//
//               // content area section
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: ContentArea(
//                     child: Obx(() => ListView.separated(
//                       physics: BouncingScrollPhysics(),
//                         itemBuilder: (BuildContext context, int index) {
//                           return QuestionCard(model: _questionPaperController.allPaper[index]);
//                         },
//                         separatorBuilder: (BuildContext context, int index) {
//                           return const SizedBox(
//                             height: 1,
//                           );
//                         },
//                         itemCount: _questionPaperController.allPaper.length)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   },)
// );


