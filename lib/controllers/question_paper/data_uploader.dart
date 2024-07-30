import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/firebase_ref/References.dart';
import 'package:quiz_zone/firebase_ref/loading_status.dart';
import 'package:quiz_zone/models/questionPaperModel.dart';
import 'package:quiz_zone/models/question_paper_model.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadDataCdata();
    super.onReady();
  }



  final loadingStatus = LoadingStatus.loading.obs; // loading status is observable
  void uploadData() async {
    loadingStatus.value = LoadingStatus.loading;//0
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // loading the json data
    final paperInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/papers") && path.contains(".json"))
        .toList();

    List<QuestionPaperModel> questionPapers= [];

    for (var paper in paperInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers.add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
    }

    var batch = fireStore.batch();

    for(var paper in questionPapers){
      batch.set(questionPaperRf.doc(paper.id),
        {
          "title" : paper.title,
          "image_url":paper.imageUrl,
          "description":paper.description,
          "time_seconds":paper.timeSeconds,
          "question_count":paper.questions==null?0:paper.questions!.length,
        }
      );
      for(var questions in paper.questions!){
        final questionPath = questionRF(paperId: paper.id, questionId: questions.id);
        batch.set(questionPath, {
          "question":questions.question,
          "correct_answer":questions.correctAnswer,
        });
        for(var answers in questions.answers){
          batch.set(questionPath.collection("answers").doc(answers.identifier),{
            "identifier": answers.identifier,
            "answer":answers.answer,
          });
        }

      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;


  }


  void uploadDataCdata() async{
    loadingStatus.value = LoadingStatus.loading;
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // loading the json data
    final paperInAssets = manifestMap.keys
        .where((path)=>
    path.startsWith("assets/DB/programing_paper") && path.contains(".json")
    )
        .toList();

    List<questionPapersModel> quizPapers= [];

    for(var paper in paperInAssets){
      String stringPaperContent = await rootBundle.loadString(paper);
      quizPapers.add(questionPapersModel.fromJson(json.decode(stringPaperContent)));
    }

    var batch = fireStore.batch();

    for(var subject in quizPapers){
      batch.set(quizPaperRf.doc(subject.id),
        {
          "title" : subject.title,
          "image_url":subject.imageUrl,
          "description":subject.description,
        }
      );

      for(var topics in subject.topics!){
        final topicsPath = topicsRef(sub_id: subject.id);
        batch.set(topicsPath.doc(topics.id),{
          "level":topics.level,
          "question_count":topics.question_count,
          "time_seconds":600,
        });

        for(var questions in topics.questions!){
          final questionPath = questionRef(sub_id: subject.id, topic_id: topics.id);
          batch.set(questionPath.doc(questions.id), {
            "question":questions.question,
            "correct_answer":questions.correctAnswer
          });

          for(var answer in questions.answers){
            batch.set(questionPath.doc(questions.id).collection("answers").doc(answer.identifier),{
              "identifier":answer.identifier,
              "answer":answer.answer,
            });
          }


        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
