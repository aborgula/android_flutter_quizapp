import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:hci/configs/themes/custom_text_styles.dart';
import 'package:get/get.dart';
import 'package:hci/controllers/theme_controller.dart';
import 'package:hci/controllers/zoom_drawer_controller.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hci/widgets/app_circle_button.dart';
import 'package:hci/widgets/content_area.dart';
import 'package:hci/screens/home/menu_screen.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/common/main_button.dart';

class ScoreScreen extends GetView<MyZoomDrawerController> {
  const ScoreScreen({Key? key}) : super(key: key);

  static const String routeName = '/score';

  @override
  Widget build(BuildContext context) {
    ThemeController _themeController = Get.find();

    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_) {
        return Obx(() {
          // Dynamiczny gradient
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
                                  "My score",
                                  style: headerText.copyWith(fontSize: 32),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ContentArea(
                              color: colorBack,
                              addPadding: false,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/dart.png',
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(height: 20),
                                    Obx(() {
                                      final AuthController authController = Get.find();

                                      return FutureBuilder<int>(
                                        future: authController.getUserScore(),
                                        builder: (context, snapshot) {
                                          int userScore = snapshot.data ?? 0;
                                          return Text(
                                            '$userScore points',
                                            style: headerText.copyWith(
                                              fontSize: 40,
                                              color: const Color(0xFFFF9B23),
                                            ),
                                          );
                                        },
                                      );
                                    }),

                                    ColoredBox(
                                      color: colorBack,
                                      child: Padding(
                                        padding: UIParameters.mobileScreenPadding,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: MainButton(
                                                onTap: () {
                                                  Get.toNamed('/streak');
                                                },
                                                title: 'STREAK',
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: MainButton(
                                                onTap: () {
                                                  Get.toNamed('/awards');
                                                },
                                                title: 'AWARDS',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
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
