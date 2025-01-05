import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hci/configs/themes/custom_text_styles.dart';
import 'package:hci/configs/themes/ui_parameters.dart';
import 'package:hci/controllers/auth_controller.dart';
import 'package:hci/controllers/question_paper/question_paper_controller.dart';
import 'package:hci/controllers/zoom_drawer_controller.dart';
import 'package:get/get.dart';
import 'package:hci/screens/home/menu_screen.dart';
import 'package:hci/screens/home/question_card.dart';
import 'package:hci/widgets/app_circle_button.dart';
import 'package:hci/widgets/content_area.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../controllers/theme_controller.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {

    QuizPaperController _quizPaperController = Get.find();
    ThemeController _themeController = Get.find();

    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_) {
        return Obx(() {
          final  Gradient gradient = _themeController.isDarkMode.value
              ? mainGradientDark
              : mainGradientLight;

          final  Color colorBack = _themeController.isDarkMode.value
              ? Color(0xFF2e3c62)
              : Color.fromARGB(255, 240, 237, 255);

          final  Color colorCard= _themeController.isDarkMode.value
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               /** ElevatedButton(
                                  onPressed: () {
                                    /**_authcontroller.testScheduleNotification();
                                    AwesomeNotifications().createNotification(
                                      content: NotificationContent(
                                        id: 10, // Unique ID for the notification
                                        channelKey: 'basic_channel',
                                        title: 'Immediate Notification',
                                        body: 'This notification is sent immediately after triggering the method.',
                                        notificationLayout: NotificationLayout.Default,
                                      ),
                                    );
**/                                 _quizPaperController.handleShake();

                                  },
                                  child: const Text("Schedule Notification"),
                                ),**/

                                AppCircleButton(
                                  child: const Icon(
                                    Icons.menu,
                                    size: 28,
                                  ),
                                  onTap: controller.toogleDrawer,
                                ),
                                AppCircleButton(
                                  child: Obx(() {
                                    return Icon(
                                      _themeController.isDarkMode.value
                                          ? Icons.nightlight
                                          : Icons.nightlight_outlined,
                                      size: 26,
                                      color: Colors.white.withOpacity(0.7),
                                    );
                                  }),
                                  onTap: () {
                                    _themeController.toggleTheme();
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  const FaIcon(FontAwesomeIcons.handPeace, size: 20),
                                  Text(
                                    "  Hello friend",
                                    style: detailText.copyWith(
                                      color: onSurfaceTextColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "What do you want to learn today?",
                              style: headerText,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ContentArea(
                              color: colorBack,
                              addPadding: false,
                              child: Obx(() => ListView.separated(
                                padding: UIParameters.mobileScreenPadding,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return QuestionCard(
                                    color: colorCard,
                                    model: _quizPaperController.allPapers[index],
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(height: 20);
                                },
                                itemCount: _quizPaperController.allPapers.length,
                              )),
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



