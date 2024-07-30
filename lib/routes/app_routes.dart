import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quiz_zone/Screens/Splash/splash_screen.dart';
import 'package:quiz_zone/Screens/home/home_screen.dart';
import 'package:quiz_zone/Screens/login/login_screen.dart';
import 'package:quiz_zone/Screens/question/answer_check_screen.dart';
import 'package:quiz_zone/Screens/question/question_screen.dart';
import 'package:quiz_zone/Screens/question/result_screen.dart';
import 'package:quiz_zone/Screens/question/test_overview_screen.dart';
import 'package:quiz_zone/Screens/question/topics_list_screen.dart';
import 'package:quiz_zone/controllers/question_paper/question_paper_controller.dart';
import 'package:quiz_zone/controllers/question_paper/questions_controller.dart';
import 'package:quiz_zone/controllers/question_paper/topic_list_controller.dart';
import 'package:quiz_zone/controllers/zoom_drawer_controller.dart';

import '../Screens/Introduction/introductions_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/introduction", page: () => AppIntroductionScreen()),
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(
            name: HomeScreen.routeName,
            page: () => HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            })),
        GetPage(
            name: QuestionsScreen.routeName,
            page: () => QuestionsScreen(),
            binding: BindingsBuilder(() {
              Get.put<QuestionsController>(QuestionsController());
            })),
        GetPage(name: TextOverviewScreen.routeName, page: ()=>TextOverviewScreen()),
        GetPage(name: ResultScreen.routeName, page: ()=>ResultScreen()),
        // GetPage(name: AnswerCheckScreen.routeName, page: ()=>AnswerCheckScreen()),


    //

    GetPage(name: TopicsListScreen.routeName, page: ()=>TopicsListScreen(),binding: BindingsBuilder((){
      Get.put<TopicsListController>(TopicsListController());
    })),


      ];
}
