import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/models/questionPaperModel.dart';

import '../../Screens/question/question_screen.dart';
import '../../firebase_ref/References.dart';
import '../../firebase_ref/loading_status.dart';

class TopicsListController extends GetxController{
  late questionPapersModel subjectPaperModel;
  final loadingStatus = LoadingStatus.loading.obs;
  final allTopics = <QuizLevels>[];

  String get subjectTitle =>subjectPaperModel.title;
  int get topicsCount =>subjectPaperModel.topics!.length;

  @override
  void onReady() {
    final _subjectModel = Get.arguments as questionPapersModel;
    loadData(_subjectModel);
    super.onReady();
  }

  String topicName(int index){
    return subjectPaperModel.topics![index].level;
  }

  int questionCount(int index){
    return subjectPaperModel.topics![index].question_count;
  }

  Future<void> loadData(questionPapersModel subjectModel) async{
    loadingStatus.value = LoadingStatus.loading;

    subjectPaperModel = subjectModel;
    try{
      final QuerySnapshot<Map<String,dynamic>> topicsQuery =  await quizPaperRf.doc(subjectPaperModel.id).collection("topics").get();
      final topics = topicsQuery.docs.map((snapshot) => QuizLevels.fromSnapshot(snapshot)).toList();

      subjectPaperModel.topics = topics;
      loadingStatus.value = LoadingStatus.completed;
    }catch(e){
      if(kDebugMode){
        print(e.toString());
      }
    }
  }

  void tryAgainTest({required QuizLevels paper}){
    Get.back();
    Get.offNamed(QuestionsScreen.routeName,arguments:  {
      "subjectID":subjectPaperModel.id,
      "topicsData": paper
    },preventDuplicates: false);
  }
}