import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:hci/configs/themes/custom_text_styles.dart';
import 'package:get/get.dart';
import 'package:hci/controllers/theme_controller.dart';
import 'package:hci/controllers/zoom_drawer_controller.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hci/screens/home/liked_question.dart';
import 'package:hci/widgets/app_circle_button.dart';
import 'package:hci/widgets/content_area.dart';
import 'package:hci/screens/home/menu_screen.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../controllers/question_paper/question_paper_controller.dart';


class LikedScreen extends GetView<MyZoomDrawerController> {
  const LikedScreen({Key? key}) : super(key: key);

  static const String routeName = '/liked';

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizPaperController = Get.find();
    ThemeController _themeController = Get.find();

    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_) {
        return Obx(() {

          final Gradient gradient = _themeController.isDarkMode.value
              ? mainGradientDark
              : mainGradientLight;

          final Color colorBack = _themeController.isDarkMode.value
              ? Color(0xFF2e3c62)
              : Color.fromARGB(255, 240, 237, 255);

          final Color colorCard = _themeController.isDarkMode.value
              ? Color(0xFF697eb5)
              : Color.fromARGB(255, 254, 254, 255);

          return Container(
            decoration: BoxDecoration(gradient: gradient),
            child: ZoomDrawer(
              borderRadius: 50.0,
              controller: _.zoomDrawerController,
              angle: 0.0,
              style: DrawerStyle.defaultStyle,
              slideWidth: MediaQuery.of(context).size.width * 0.65,
              menuScreen: Container(
                decoration: BoxDecoration(gradient: gradient),
                child: MyMenuScreen(),
              ),
              mainScreen: Container(
                decoration: BoxDecoration(gradient: gradient),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(19),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppCircleButton(
                                  child: const Icon(
                                    Icons.menu,
                                    size: 28,
                                  ),
                                  onTap: controller.toogleDrawer,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[ Image.asset(
                                    'assets/images/heart.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),]
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Liked quizzes",
                                  style: headerText.copyWith(fontSize: 32),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ContentArea(
                            color: colorBack,
                            addPadding: false,
                            child: Obx(() => ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final quiz = _quizPaperController.favoritePapers[index];

                                return Dismissible(
                                  key: Key(quiz.id), // Use a unique key for each item
                                  direction: DismissDirection.endToStart, // Enable swipe from right to left
                                  onDismissed: (direction) {
                                    _quizPaperController.removeFavorite(quiz.id); // Define this method in the controller
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${quiz.title} removed from favorites')),
                                    );
                                  },
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    color: Colors.red.withOpacity(0.4),
                                    child:  Icon(Icons.delete, color: Colors.white.withOpacity(0.8),
                                    size: 32,),
                                  ),
                                  child: LikedQuestion(
                                    color: colorCard,
                                    model: quiz,
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(height: 20);
                              },
                              itemCount: _quizPaperController.favoritePapers.length,
                            ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03
                  ,)

                    ],
                  ),
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}
