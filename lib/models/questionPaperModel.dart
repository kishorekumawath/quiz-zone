import 'package:cloud_firestore/cloud_firestore.dart';

class questionPapersModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  List<QuizLevels>? topics;

  questionPapersModel(
      {required this.id,required this.title, this.imageUrl, required this.description, this.topics});

  questionPapersModel.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    title = json['title'],
    imageUrl = json['image_url'],
    description = json['description'],
    topics = (json['topics'] as List)
        .map((dynamic e) =>  QuizLevels.fromJson(e as Map<String,dynamic>))
        .toList();

  questionPapersModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) :
        id = json.id,
        title = json['title'],
        imageUrl = json['image_url'],
        description = json['description'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['description'] = this.description;
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuizLevels {
  String id;
  String level;
  int question_count;
  int timeSeconds;
  List<Questions>? questions;

  QuizLevels({required this.id,required this.level, required this.question_count, required this.timeSeconds, this.questions});

  QuizLevels.fromJson(Map<String, dynamic> json) :
      id = json['id'],
    level = json['level'],
    question_count = json['question_count'],
    timeSeconds = json['time_seconds'],
    questions = (json['questions'] as List)
        .map((dynamic e) =>Questions.fromJson(e as Map<String,dynamic>))
        .toList();

  QuizLevels.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) :
        id = json.id,
        level = json['level'],
        question_count = json['question_count'],
        timeSeconds = json['time_seconds'] as int;

  String timeInMints() => "${(timeSeconds / 60).ceil()} mins";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['count'] = this.question_count;
    data['time_seconds'] = this.timeSeconds;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String id;
  String question;
  List<Answers> answers;
  String? correctAnswer;
  String? selectedAnswer;

  Questions({required this.id,required this.question,required this.answers, this.correctAnswer});

  Questions.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    question = json['question'],
    correctAnswer = json['correct_answer'],
    answers = (json['answers'] as List)
            .map((dynamic e) => Answers.fromJson(e))
            .toList();

  Questions.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) :
        id = json.id,
        question = json['question'],
        correctAnswer = json['correct_answer'],
        answers = [];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  Answers.fromJson(Map<String, dynamic> json) :
    identifier = json['identifier'],
    answer = json['answer'];


  Answers.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) :
        identifier = json['identifier'] as String?,
        answer = json['answer'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['answer'] = this.answer;
    return data;
  }
}