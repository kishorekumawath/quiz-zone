import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/Screens/question/question_screen.dart';
import 'package:quiz_zone/Screens/question/topics_list_screen.dart';
import 'package:quiz_zone/controllers/auth_controller.dart';
import 'package:quiz_zone/firebase_ref/References.dart';
import 'package:quiz_zone/firebase_ref/loading_status.dart';
import 'package:quiz_zone/models/questionPaperModel.dart';
import 'package:quiz_zone/models/question_paper_model.dart';
import 'package:quiz_zone/services/firebase_storage_services.dart';

class QuestionPaperController extends GetxController{
  final allPaperImages = <String>[].obs;
  final allPaper = <QuestionPaperModel>[].obs;
  final loadingData = LoadingStatus.loading.obs;

  final allSubjects = <questionPapersModel>[].obs;

  @override
  void onReady() {
    // getAllPaper();
    getAllSubjectsPaper();
    super.onReady();
  }
  // Future<void> getAllPaper() async{
  //   try{
  //     QuerySnapshot<Map<String,dynamic>> data = await questionPaperRf.get();
  //     final paperList = data.docs.map((paper) => QuestionPaperModel.fromSnapshot(paper)).toList();
  //     allPaper.assignAll(paperList);
  //     for(var paper in paperList){
  //       final imgUrl = await Get.find<FirebaseStorageServices>().getImage(paper.title);
  //       paper.imageUrl = imgUrl;
  //     }
  //     allPaper.assignAll(paperList);
  //   }catch(e){
  //     print("error occurred at question paper controller $e");
  //   }
  //
  // }

  // void navigateToQuestion({required QuestionPaperModel paper,bool tryAgain = false}){
  //   AuthController _authController = Get.find();
  //   if(_authController.isLoggedIn()){
  //     if(tryAgain){
  //       Get.back();
  //       Get.offNamed(QuestionsScreen.routeName,arguments: paper,preventDuplicates: false);
  //     }else{
  //       Get.toNamed(QuestionsScreen.routeName,arguments: paper);
  //     }
  //   }else{
  //     _authController.showLoginAlertDialog();
  //   }
  // }

  void navigateToTopicsListScreen({required questionPapersModel subject}){
    AuthController _authController = Get.find();
    if(_authController.isLoggedIn()){
      // if(tryAgain){
      //   // Get.back();
      //   // Get.offNamed(QuestionsScreen.routeName,arguments: paper,preventDuplicates: false);
      // }else{
        // Get.toNamed(QuestionsScreen.routeName,arguments: paper);
        Get.toNamed(TopicsListScreen.routeName,arguments: subject);
      // }
    }else{
      _authController.showLoginAlertDialog();
    }
  }


  Future<void> getAllSubjectsPaper() async{
    loadingData.value = LoadingStatus.loading;
    try{
      QuerySnapshot<Map<String,dynamic>> data = await quizPaperRf.get();
      final subjectList = data.docs.map((subject) => questionPapersModel.fromSnapshot(subject)).toList();
      allSubjects.assignAll(subjectList);
      for(var subject in subjectList){
        final imgUrl = await Get.find<FirebaseStorageServices>().getImageUrl(subject.title);
        subject.imageUrl = imgUrl;
      }
      allSubjects.assignAll(subjectList);
      loadingData.value = LoadingStatus.completed;
    }catch(e){
      print("----> error occurred while fetching the subject paper in question_paper_controller file $e");
    }
  }

}