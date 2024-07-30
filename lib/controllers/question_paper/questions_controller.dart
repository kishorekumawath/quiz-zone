import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/Screens/home/home_screen.dart';
import 'package:quiz_zone/Screens/question/result_screen.dart';
import 'package:quiz_zone/controllers/auth_controller.dart';
import 'package:quiz_zone/controllers/question_paper/question_controller_extension.dart';
import 'package:quiz_zone/controllers/question_paper/question_paper_controller.dart';
import 'package:quiz_zone/controllers/question_paper/topic_list_controller.dart';
import 'package:quiz_zone/firebase_ref/References.dart';
import 'package:quiz_zone/firebase_ref/loading_status.dart';
import 'package:quiz_zone/models/questionPaperModel.dart';

class QuestionsController extends GetxController{
  late QuizLevels quizTopicSelected;
  late String subjectID;
  final loadingStatus = LoadingStatus.loading.obs;
  final allQuestion = <Questions>[];
  final questionIndex = 0.obs;
  bool get isFirstQuestion =>questionIndex.value>0;
  bool get isLastQuestion =>questionIndex.value>=allQuestion.length-1;

  Timer?_timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  Rxn<Questions> currentQuestion = Rxn<Questions>();
  @override
  void onReady() {
    final _paper= Get.arguments as Map<String,dynamic>;
    loadData(_paper);
    super.onReady();
  }

  void loadData(Map<String,dynamic> paper) async{
    loadingStatus.value = LoadingStatus.loading;
    subjectID = paper['subjectID'] as String;
    quizTopicSelected = paper['topicsData'] as QuizLevels;
    try{
      final QuerySnapshot<Map<String,dynamic>> questionQuery =  await quizPaperRf.doc(subjectID).collection("topics").doc(quizTopicSelected.id).collection("questions").get();
      final questions = questionQuery.docs.map((snapshot) => Questions.fromSnapshot(snapshot)).toList();
      quizTopicSelected.questions = questions;

      for(Questions _question in quizTopicSelected.questions!){
        final QuerySnapshot<Map<String,dynamic>> answerQuery = await quizPaperRf.doc(subjectID).collection("topics").doc(quizTopicSelected.id).collection("questions").doc(_question.id).collection("answers").get();
        final answers = answerQuery.docs.map((answer) => Answers.fromSnapshot(answer)).toList();
        _question.answers=answers;
      }
    }catch(e){
      if(kDebugMode){
        print(e.toString());
      }
    }

    if(quizTopicSelected.questions!=null&&quizTopicSelected.questions!.isNotEmpty){
      currentQuestion.value = quizTopicSelected.questions![0];
      allQuestion.assignAll(quizTopicSelected.questions!);
      _startTimer(quizTopicSelected.timeSeconds);
      loadingStatus.value = LoadingStatus.completed;

    }else{
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer){
    currentQuestion.value!.selectedAnswer =  answer;
    update(['answer_list']);// update the ui which id name is answer_list u can find the in the getBuilder where u have used in question_screen
  }

  String get completeTest{
    final answered = allQuestion.where((element) => element.selectedAnswer!=null).toList().length;
    return '$answered out of ${allQuestion.length} answered';
  }

  void nextQuestion(){
    if(questionIndex.value>=allQuestion.length-1){
      return;
    }
    questionIndex.value++;
    currentQuestion.value = allQuestion[questionIndex.value];
  }

  void jumpToQuestion(int index,{bool isGoBack = true}){
    questionIndex.value = index;
    currentQuestion.value = allQuestion[index];
    if(isGoBack){
      Get.back();
    }
  }

  void prevQuestion(){
    if(questionIndex.value<=0){
      return;
    }
    questionIndex.value--;
    currentQuestion.value = allQuestion[questionIndex.value];
  }

  _startTimer(int seconds){
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if(remainSeconds==0){
        timer.cancel();
      }else{
        int min = remainSeconds~/60;  // ex 170/60<-- 2.3.. we will save 2
        int sec = remainSeconds%60;
        time.value = min.toString().padLeft(2,"0")+":"+sec.toString().padLeft(2,"0");
        remainSeconds--;

      }
    });

  }


  void submit(){
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }
  //
  void tryAgain(){
    Get.find<TopicsListController>().tryAgainTest(paper: quizTopicSelected);
  }
  //
  Future<void> saveTestResult() async{
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();

    if(_user==null) return null;
    batch.set(userRf.doc(_user.email).collection("myRecent_tests").doc(quizTopicSelected.id), {
      "points" :points,
      "correct_answer" : '$correctAnswerCount/${allQuestion.length}',
      "question_id":quizTopicSelected.id,
      "time":quizTopicSelected.timeSeconds-remainSeconds,

    });

    batch.commit();
    navigateToHome();

  }

  void navigateToHome(){
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName,(route)=>false);// this will remove everything and start from home screen
  }

}






// class QuestionsController extends GetxController{
//   late QuestionPaperModel questionPaperModel;
//   final loadingStatus = LoadingStatus.loading.obs;
//   final allQuestion = <Questions>[];
//   final questionIndex = 0.obs;
//   bool get isFirstQuestion =>questionIndex.value>0;
//   bool get isLastQuestion =>questionIndex.value>=allQuestion.length-1;
//
//   Timer?_timer;
//   int remainSeconds = 1;
//   final time = '00.00'.obs;
//
//   Rxn<Questions> currentQuestion = Rxn<Questions>();
//   @override
//   void onReady() {
//     final _questionPaper= Get.arguments as QuestionPaperModel;
//     loadData(_questionPaper);
//     super.onReady();
//   }
//
//   void loadData(QuestionPaperModel questionPaper) async{
//     questionPaperModel = questionPaper;
//     loadingStatus.value = LoadingStatus.loading;
//     try{
//       final QuerySnapshot<Map<String,dynamic>> questionQuery =  await questionPaperRf.doc(questionPaperModel.id).collection("questions").get();
//       final questions = questionQuery.docs.map((snapshot) => Questions.fromSnapshot(snapshot)).toList();
//
//       questionPaperModel.questions = questions;
//
//       for(Questions _question in questionPaperModel.questions!){
//         final QuerySnapshot<Map<String,dynamic>> answerQuery = await questionPaperRf.doc(questionPaper.id).collection("questions").doc(_question.id).collection("answers").get();
//         final answers = answerQuery.docs.map((answer) => Answers.fromSnapshot(answer)).toList();
//         _question.answers=answers;
//       }
//     }catch(e){
//       if(kDebugMode){
//         print(e.toString());
//       }
//     }
//
//     if(questionPaper.questions!=null&&questionPaper.questions!.isNotEmpty){
//       currentQuestion.value = questionPaper.questions![0];
//       allQuestion.assignAll(questionPaper.questions!);
//       _startTimer(questionPaper.timeSeconds);
//       loadingStatus.value = LoadingStatus.completed;
//
//     }else{
//       loadingStatus.value = LoadingStatus.error;
//     }
//   }
//
//   void selectedAnswer(String? answer){
//     currentQuestion.value!.selectedAnswer =  answer;
//     update(['answer_list']);// update the ui which id name is answer_list u can find the in the getBuilder where u have used in question_screen
//   }
//
//   String get completeTest{
//     final answered = allQuestion.where((element) => element.selectedAnswer!=null).toList().length;
//     return '$answered out of ${allQuestion.length} answered';
//   }
//
//   void nextQuestion(){
//     if(questionIndex.value>=allQuestion.length-1){
//       return;
//     }
//     questionIndex.value++;
//     currentQuestion.value = allQuestion[questionIndex.value];
//   }
//
//   void jumpToQuestion(int index,{bool isGoBack = true}){
//     questionIndex.value = index;
//     currentQuestion.value = allQuestion[index];
//     if(isGoBack){
//       Get.back();
//     }
//   }
//
//   void prevQuestion(){
//     if(questionIndex.value<=0){
//       return;
//     }
//     questionIndex.value--;
//     currentQuestion.value = allQuestion[questionIndex.value];
//   }
//
//   _startTimer(int seconds){
//     const duration = Duration(seconds: 1);
//     remainSeconds = seconds;
//     _timer = Timer.periodic(duration, (Timer timer) {
//       if(remainSeconds==0){
//         timer.cancel();
//       }else{
//         int min = remainSeconds~/60;  // ex 170/60<-- 2.3.. we will save 2
//         int sec = remainSeconds%60;
//         time.value = min.toString().padLeft(2,"0")+":"+sec.toString().padLeft(2,"0");
//         remainSeconds--;
//
//       }
//     });
//
//   }
//
//
//   void submit(){
//     _timer!.cancel();
//     Get.offAndToNamed(ResultScreen.routeName);
//   }
//
//   void tryAgain(){
//     Get.find<QuestionPaperController>().navigateToQuestion(paper: questionPaperModel,tryAgain: true);
//   }
//
//   Future<void> saveTestResult() async{
//     var batch = fireStore.batch();
//     User? _user = Get.find<AuthController>().getUser();
//
//     if(_user==null) return null;
//     batch.set(userRf.doc(_user.email).collection("myRecent_tests").doc(questionPaperModel.id), {
//       "points" :points,
//       "correct_answer" : '$correctAnswerCount/${allQuestion.length}',
//       "question_id":questionPaperModel.id,
//       "time":questionPaperModel.timeSeconds-remainSeconds,
//
//     });
//
//     batch.commit();
//     navigateToHome();
//
//   }
//
//   void navigateToHome(){
//     _timer!.cancel();
//     Get.offNamedUntil(HomeScreen.routeName,(route)=>false);// this will remove everything and start from home screen
//   }
//
// }