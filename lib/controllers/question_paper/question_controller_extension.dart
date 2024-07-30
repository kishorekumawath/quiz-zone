import 'package:quiz_zone/controllers/question_paper/questions_controller.dart';

extension QuestionControllerExtension on QuestionsController{

  int get correctAnswerCount => allQuestion.where((element) => element.selectedAnswer==element.correctAnswer).toList().length;

  String get correctAnsweredQuestion {
    return "$correctAnswerCount out of ${allQuestion.length} are correct";
  }

  String get points{
    // var points = (correctAnswerCount/allQuestion.length)*100*(quizTopicSelected.timeSeconds-remainSeconds)/quizTopicSelected.timeSeconds*100;
    var points = (correctAnswerCount/allQuestion.length)*100;
    return points.toStringAsFixed(2);
  }


}