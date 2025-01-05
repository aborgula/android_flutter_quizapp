import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci/configs/themes/custom_text_styles.dart';
import 'package:hci/configs/themes/ui_parameters.dart';
import 'package:hci/controllers/question_paper/question_paper_controller.dart';
import 'package:hci/models/question_paper_model.dart';
import 'package:get/get.dart';
import 'package:hci/widgets/app_icon_text.dart';

import '../../controllers/auth_controller.dart';

class QuestionCard extends GetView<QuizPaperController> {
  final Color? color;

  const QuestionCard({
    Key? key,
    required this.model,
    this.color,
  }) : super(key: key);

  final QuestionPaperModel model;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    final RxBool isFavorite = false.obs;

    final AuthController authController = Get.find<AuthController>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: color ?? Theme.of(context).cardColor,
      ),
      child: InkWell(
        onTap: () {
          controller.navigateToQuestions(
            paper: model,
            tryAgain: false,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        child: CachedNetworkImage(
                          imageUrl: model.imageUrl!,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/app_splash_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: cartTitles(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(model.description),
                        ),
                        Row(
                          children: [
                            AppIconText(
                              icon: Icon(
                                Icons.help_outline_sharp,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                '${model.questionsCount} questions',
                                style: detailText.copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            AppIconText(
                              icon: Icon(
                                Icons.timer,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                model.timeInMinits(),
                                style: detailText.copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Ikona serca w prawym górnym rogu
              Positioned(
                top: 1,
                right: 2,
                child: Obx(
                      () => GestureDetector(
                    onTap: () {
                      authController.toggleFavoriteQuiz(model.id);
                    },
                    child: authController.isLogged.value ? Icon(
                      authController.isQuizFavorite(model.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: authController.isQuizFavorite(model.id)
                          ? Colors.red
                          : Colors.grey.withOpacity(0.4),
                      size: 24,
                    ):
                        SizedBox.shrink(),
                  ),
                ),
              ),
              Positioned(
                bottom: -_padding,
                right: -_padding,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 19),
                  child: Icon(
                    Icons.emoji_events_outlined,
                    size: 22,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight:
                      Radius.circular(10),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



