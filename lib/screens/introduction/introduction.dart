import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:hci/widgets/app_circle_button.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = (screenWidth > 600) ? screenWidth * 0.1 : screenWidth * 0.2;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppCircleButton(
                child: const Icon(
                  Icons.star,
                  size: 65,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Ready for a challenge? Start taking quizzes and see how much you know! Challenge yourself in different categories and level up your knowledge!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              AppCircleButton(
                onTap: () => Get.offAndToNamed('/home'),  // Przejście do HomeScreen
                child: const Icon(Icons.arrow_forward, size: 35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}