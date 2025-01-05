import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:hci/configs/themes/custom_text_styles.dart';
import 'package:hci/configs/themes/ui_parameters.dart';
import 'package:hci/controllers/question_paper/questions_controller.dart';
import 'package:hci/firebase_ref/loading_status.dart';
import 'package:hci/screens/question/test_overview_screen.dart';
import 'package:hci/widgets/common/background_decoration.dart';
import 'package:hci/widgets/common/custom_app_bar.dart';
import 'package:hci/widgets/common/main_button.dart';
import 'package:hci/widgets/content_area.dart';
import 'package:hci/widgets/questions/answer_card.dart';
import 'package:hci/widgets/questions/countdown_timer.dart';
import '../../widgets/common/question_place_holder.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({Key? key}) : super(key: key);
  static const String routeName = "/questionsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const ShapeDecoration(
              shape: StadiumBorder(
                side: BorderSide(color:onSurfaceTextColor, width: 2)
              )
          ),
          child: Obx(()=>CountdownTimer(
              time: controller.time.value,
              color: onSurfaceTextColor,
          ))
        ),

        showActionIcon: true,
        titleWidget: Obx(
            () => Text(
                "Q. ${(controller.questionIndex.value+1).toString().padLeft(2,'0')}",
            style: appBarTS,
              ),
        ),

      ),
      body: BackgroundDecoration(
        child: Obx(
              () => Column(
            children: [
              // 1. Jeśli trwa ładowanie
              if (controller.loadingStatus.value == LoadingStatus.loading)
                const Expanded(
                  child: ContentArea(
                    child: QuestionScreenHolder(),
                  ),
                ),

              // 2. Jeśli dane się załadowały
              if (controller.loadingStatus.value == LoadingStatus.completed)
                Expanded(
                  child: ContentArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          // Wyświetlamy pytanie
                          Center(
                            child: Text(
                              controller.currentQuestion.value!.question,
                              style: questionTS,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Lista odpowiedzi w GetBuilder
                          GetBuilder<QuestionsController>(
                            id: 'answers_list',
                            builder: (context) {

                              return ListView.separated(

                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 25),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  final answer = controller.currentQuestion.value!.answers[index];
                                  return AnswerCard(
                                    answer: '${answer.identifier}. ${answer.answer}',
                                    onTap: () {
                                      controller.selectedAnswer(answer.identifier);
                                    },
                                    isSelected: answer.identifier ==
                                        controller.currentQuestion.value!.selectedAnswer,
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) =>
                                const SizedBox(height: 10),
                                itemCount: controller.currentQuestion.value!.answers.length,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
              ColoredBox(
                  color: customScaffoldColor(context),
                  child: Padding(
                      padding: UIParameters.mobileScreenPadding,
                      child: Row(
                        children: [
                          Visibility(
                            visible: controller.isFirstQuestion,
                            child: SizedBox(
                              width: 55,
                              height: 55,
                              child: MainButton(
                                  onTap: (){
                                    controller.prevQuestion();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: Visibility(
                                visible: controller.loadingStatus.value==LoadingStatus.completed,
                                child: MainButton(
                                  onTap: (){
                                    controller.isLastQuestion?Get.toNamed(TestOverviewScreen.routeName):
                              controller.nextQuestion();
                            },
                            title: controller.isLastQuestion?'Complete':'Next',
                            )),
                          )
                        ],
                      )) )
            ],
          ),
        ),
      ),
    );
  }
}

