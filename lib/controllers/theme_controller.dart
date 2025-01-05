import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hci/configs/themes/app_light_theme.dart';
import '../configs/themes/app_dark_theme.dart';

class ThemeController extends GetxController {

  late ThemeData _darkTheme;
  late ThemeData _lightTheme;

  @override
  void onInit(){
    initializeThemeData();
    super.onInit();
  }

  initializeThemeData(){
    _darkTheme = DarkTheme().buildDarkTheme();
    _lightTheme = LightTheme().buildLightTheme();
  }

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;


  var isDarkMode = RxBool(false);

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value; // Zmień tryb
    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
    update();
  }
}