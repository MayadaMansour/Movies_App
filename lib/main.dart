import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/ui/splash/board_screen.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';
import 'package:moves_app_project/ui/utils/theme/theme.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyBVkZFszWZB7OfIcW_gcma3DUwotbfgvrQ",
              appId: "com.example.app_news",
              messagingSenderId: "918353559368",
              projectId: "movie-app-eb56c"))
      :
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MovieHomeCubit>(
          create: (context) => MovieHomeCubit()
            ..getPopularMovies()
            ..getUpComingMovies()
            ..getTopRateMovies(),
        ),
      ],
      child: const MyApp(),
    ),
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
        // Add other routes here
      },
    );
  }
}
