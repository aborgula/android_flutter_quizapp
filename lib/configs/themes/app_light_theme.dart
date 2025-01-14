import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hci/configs/themes/sub_theme_data_mixin.dart';

const Color primaryLightColorLight = Color(0xFF3ac3cb);
const Color primaryColorLight = Color(0xFFf85187);
const Color mainTextColorLight = Color.fromARGB(255,40,40,40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);
const Color buttonColor = Color(0xFF2e3c62);


class LightTheme with SubThemeData{
  ThemeData buildLightTheme(){
      final ThemeData systemLightTheme = ThemeData.light();
      return systemLightTheme.copyWith(
        primaryColor: primaryColorLight,
        iconTheme: getIconTheme(),
        cardColor: cardColor,
        textTheme: getTextThemes().apply(
          bodyColor: mainTextColorLight,
          displayColor: mainTextColorLight
        )
      );
  }
}