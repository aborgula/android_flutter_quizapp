import 'package:flutter/material.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:hci/configs/themes/ui_parameters.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class MyMenuScreen extends GetView<AuthController> {
  const MyMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Container(
      padding: UIParameters.mobileScreenPadding,
      width: double.maxFinite,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: SafeArea(
        child: Column(
          children: [
            Obx(() {
              if (authController.isLogged.value &&
                  authController.loggedInUserData.isNotEmpty) {
                final userName = authController.loggedInUserData['login'];
                return Column(
                  children: [
                    Text(
                      "Welcome, $userName",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _DrawerButton(
                      icon: Icons.login,
                      label: "Log in",
                      onPressed: () {
                        Get.toNamed("/login");
                      },
                    ),
                    _DrawerButton(
                      icon: Icons.app_registration,
                      label: "Register",
                      onPressed: () {
                        Get.toNamed("/register");
                      },
                    ),
                  ],
                );
              }
            }),
            Expanded(
              child: Obx(() {
                if (authController.isLogged.value &&
                    authController.loggedInUserData.isNotEmpty) {
                  return Column(
                    children: [
                      _DrawerButton(
                        icon: Icons.flash_on,
                        label: "My streak",
                        onPressed: () => Get.toNamed('/streak'),
                      ),
                      _DrawerButton(
                        icon: Icons.stacked_line_chart,
                        label: "My score",
                        onPressed: () => Get.toNamed("/score"),
                      ),
                      _DrawerButton(
                        icon: Icons.thumb_up,
                        label: "Liked quizzes",
                        onPressed: () => Get.toNamed("/liked"),
                      ),
                      _DrawerButton(
                        icon: Icons.star_sharp,
                        label: "My awards",
                        onPressed: () => Get.toNamed("/awards"),
                      ),
                      _DrawerButton(
                        icon: Icons.home,
                        label: "Home",
                        onPressed: () => Get.toNamed("/home")
                      ),
                    ],
                  );
                }
                return const SizedBox(); // Jeśli użytkownik nie jest zalogowany
              }),
            ),
            Obx(() {
              if (authController.isLogged.value) {
                return _DrawerButton(
                  icon: Icons.logout,
                  label: "Logout",
                  onPressed: () {
                    authController.isLogged.value = false;
                    authController.loggedInUserData.clear();
                    Get.offAllNamed("/login");
                  },
                );
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({
    Key? key,
    required this.icon,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), // Odstępy między przyciskami
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            child: Icon(
              icon,
              size: 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: TextButton(
              onPressed: onPressed ?? () {},
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



