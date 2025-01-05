import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hci/configs/themes/custom_text_styles.dart';
import 'package:hci/configs/themes/ui_parameters.dart';
import 'package:hci/controllers/question_paper/questions_controller_extension.dart';
import 'package:hci/screens/question/answer_check_screen.dart';
import 'package:hci/widgets/common/background_decoration.dart';
import 'package:hci/widgets/common/custom_app_bar.dart';
import 'package:hci/widgets/common/main_button.dart';
import 'package:hci/widgets/questions/answer_card.dart';
import 'package:hci/widgets/questions/question_number_card.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/question_paper/questions_controller.dart';
import '../../widgets/content_area.dart';
import 'package:vibration/vibration.dart';


class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({Key? key}) : super(key: key);
  static const String routeName = "/resultScreen";

  IconData getIconForScore(double score) {
    if (score <= 0.3) {
      return Icons.sentiment_very_dissatisfied;
    } else if (score <= 0.55) {
      return Icons.sentiment_neutral;
    } else if (score <= 0.8){
      return Icons.sentiment_satisfied;
    }else{
      return Icons.sentiment_very_satisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    double score = controller.emojiScore; // Pobieranie wyniku
    IconData icon = getIconForScore(score); // Wybór emotki na podstawie wyniku

    Color _textColor = Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    final AuthController authController = Get.find<AuthController>();

    int parsePoints(String points) {
      double? parsedPoints = double.tryParse(points);
      if (parsedPoints == null) {
        return 0;
      }
      return parsedPoints.round();
    }

    final points = parsePoints(controller.points);
    authController.updateUserScore(points);

    if (controller.correctAnsweredQuestions == controller.allQuestions.length) {
      authController.incrementUser100Percent();
    }

     if(controller.correctQuestionCount == 0) {
      Vibration.hasVibrator().then((bool? hasVibrator) {
        if (hasVibrator == true) {
          print('has ');
          Vibration.vibrate(duration: 300);
        }
      });
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: const SizedBox(
          height: 80,
        ),
        title: controller.correctAnsweredQuestions,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    Icon(
                      icon,
                      size: 180,
                      color: const Color(0xF88F45E5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'Congratulations',
                        style: headerText.copyWith(color: _textColor),
                      ),
                    ),
                    Text(
                      'You have ${controller.points} points',
                      style: TextStyle(color: _textColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Tap below question numbers to view correct answers',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: controller.allQuestions.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_, index) {
                          final _question = controller.allQuestions[index];
                          AnswerStatus _status = AnswerStatus.notanswered;
                          final _selectedAnswer = _question.selectedAnswer;
                          final _correctAnswer = _question.correctAnswer;

                          if (_selectedAnswer == _correctAnswer) {
                            _status = AnswerStatus.correct;
                          } else if (_question.selectedAnswer == null) {
                            _status = AnswerStatus.wrong;
                          } else {
                            _status = AnswerStatus.wrong;
                          }

                          return QuestionNumberCard(
                            index: index,
                            status: _status,
                            onTap: () {
                              controller.jumpToQuestion(index, isGoBack: false);
                              Get.toNamed(AnswerCheckScreen.routeName);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.tryAgain();
                        },
                        color: const Color(0xF88F45E5),
                        title: 'Try again',
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.navigateToHome();
                        },
                        title: 'Go home',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
