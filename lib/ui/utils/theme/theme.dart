import 'package:flutter/material.dart';

import '../color_resource/color_resources.dart';

class MyThemeData {
  static final ThemeData lightMode = ThemeData(
    primaryColor: ColorResources.bgColor,
    scaffoldBackgroundColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorResources.navBar,
      selectedItemColor: ColorResources.yellow,
      unselectedItemColor: ColorResources.white,
      selectedLabelStyle: TextStyle(
        color: ColorResources.yellow,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      unselectedLabelStyle: TextStyle(
        color: ColorResources.white,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      selectedIconTheme: const IconThemeData(size: 30),
      unselectedIconTheme:
          const IconThemeData(size: 20), // Corrected size from 320 to 20
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: ColorResources.white,
        fontWeight: FontWeight.w700,
        fontSize: 22,
        fontFamily: "ElMessiri",
      ),
      bodyMedium: TextStyle(
        color: ColorResources.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
        fontFamily: "Flat",
      ),
      bodySmall: TextStyle(
        color: ColorResources.white,
        fontWeight: FontWeight.w400,
        fontSize: 18,
        fontFamily: "Flat",
      ),
    ),
  );
}
