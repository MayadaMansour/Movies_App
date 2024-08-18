import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/splash/board_screen.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';
import 'package:moves_app_project/ui/utils/theme/theme.dart';


void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: ColorResources.bgColor,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      theme: MyThemeData.lightMode,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
