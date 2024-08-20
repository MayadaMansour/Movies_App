import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/splash/board_screen.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';
import 'package:moves_app_project/ui/utils/theme/theme.dart';
import 'package:device_preview/device_preview.dart';



void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ),
);

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
