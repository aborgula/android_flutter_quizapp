import 'package:hci/controllers/question_paper/questions_controller.dart';

extension QuestionsControllerExtension on QuestionsController{

  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions{
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  double get emojiScore{
    return correctQuestionCount/allQuestions.length;
  }

  String get points {
    if (correctQuestionCount == 0) {
      return "0.00";
    }

    double correctRatio = correctQuestionCount / allQuestions.length;
    double timeFactor = (questionPaperModel.timeSeconds - remainSeconds) / questionPaperModel.timeSeconds;
    double totalPoints = correctRatio * 100 * timeFactor * 100;

    return totalPoints.toStringAsFixed(2);
  }




}