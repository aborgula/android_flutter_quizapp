import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:get/get.dart';
import 'package:hci/controllers/auth_controller.dart';
import 'package:hci/screens/login/register_screen.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    final TextEditingController loginController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/app_splash_logo.png",
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                "This is a study app. Please log in or register to access the features.",
                style: TextStyle(
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Pole tekstowe dla loginu
            TextField(
              controller: loginController,
              decoration: InputDecoration(
                labelText: "Login",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Pole tekstowe dla hasła
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ElevatedButton(
                  onPressed: () {
                    final login = loginController.text.trim();
                    final password = passwordController.text.trim();

                    controller.scheduleNotification();
                    controller.testScheduleNotification();

                    if (login.isNotEmpty && password.isNotEmpty) {
                      controller.loginWithLoginAndPassword(login: login, password: password);
                      } else {
                          Get.snackbar(
                            "Error",
                            "Please enter both login and password",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                        );
                    }
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => RegisterScreen());
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

