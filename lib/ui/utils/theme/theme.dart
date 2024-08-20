import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color_resource/color_resources.dart';

class MyThemeData {
  static final ThemeData lightMode = ThemeData(
    primaryColor: ColorResources.bgColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorResources.bgColor,
      elevation: 0,

    ),
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
      titleLarge: GoogleFonts.inter(
        textStyle: TextStyle(
          color: ColorResources.white ,
          fontSize: 22,
          fontWeight: FontWeight.w400
        ),

      ),
      titleMedium: GoogleFonts.inter(
        textStyle: TextStyle(
            color: ColorResources.white ,
            fontSize: 15,
            fontWeight: FontWeight.w400
        ),

      ),
      titleSmall: GoogleFonts.inter(
      textStyle: TextStyle(
          color: ColorResources.semiTransparentWhite ,
          fontSize: 13,
          fontWeight: FontWeight.w400
      ),

    ),
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
