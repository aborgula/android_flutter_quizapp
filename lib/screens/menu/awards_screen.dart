import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:hci/configs/themes/custom_text_styles.dart';
import 'package:get/get.dart';
import 'package:hci/controllers/theme_controller.dart';
import 'package:hci/controllers/zoom_drawer_controller.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hci/screens/home/award_card.dart';
import 'package:hci/widgets/app_circle_button.dart';
import 'package:hci/widgets/content_area.dart';
import 'package:hci/screens/home/menu_screen.dart';
import '../../controllers/question_paper/question_paper_controller.dart';


class AwardsScreen extends GetView<MyZoomDrawerController> {
  const AwardsScreen({Key? key}) : super(key: key);

  static const String routeName = '/awards';


  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizPaperController = Get.find();
    ThemeController _themeController = Get.find();

    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_) {
        return Obx(() {
          // Dynamiczny gradient
          final Gradient gradient = _themeController.isDarkMode.value
              ? mainGradientDark
              : mainGradientLight;

          final Color colorBack = _themeController.isDarkMode.value
              ? const Color(0xFF2e3c62)
              : const Color.fromARGB(255, 240, 237, 255);

          final Color colorCard = _themeController.isDarkMode.value
              ? const Color(0xFF697eb5)
              : const Color.fromARGB(255, 254, 254, 255);

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
                child: const MyMenuScreen(),
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
                            const SizedBox(height: 27),
                            // Gwiazdki i tytuł
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    5,
                                        (index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 44,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "My awards",
                                  style: headerText.copyWith(fontSize: 32),
                                ),
                                SizedBox(height: 6),
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
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GridView.count(
                                crossAxisCount: 3, // Liczba kolumn w siatce
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                children: [
                                  AwardCard(
                                    imagePath: 'assets/images/medal5.png',
                                    description: '100% in 1 quiz',
                                    id: 1
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal3.png',
                                    description: '3 quizzes liked',
                                    id: 2
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal6.png',
                                    description: '100% in 3 quizzzez',
                                    id: 3
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal14.png',
                                    description: '5 days of streak',
                                    id: 4
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal10.png',
                                    description: '100% in 5 quizzez',
                                    id: 5
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal7.png',
                                    description: '10 days of streak',
                                    id: 6
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal8.png',
                                    description: '15 days of streak',
                                    id:7
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal2.png',
                                    description: '200 points',
                                    id: 8
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal11.png',
                                    description: '600 points',
                                    id: 9
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal12.png',
                                    description: '1000 points',
                                    id:10
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal9.png',
                                    description: '100% in 8 quizzez',
                                    id: 11
                                  ),
                                  AwardCard(
                                    imagePath: 'assets/images/medal15.png',
                                    description: '1300 points',
                                    id:12
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
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


