import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_cubit.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/movie_section.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/recomended_section.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/slider_section.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieHomeCubit()
        ..getTopRateMovies()
        ..getUpComingMovies(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SliderPannar(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: MovieScreenSection(),
              ),
              const SizedBox(height: 25),
              RecomendedScreenSection(
                title: 'Recomended',
                time: '2018  R  1h 59m',
                rate: '7.7',
                movieName: 'Deadpool 2',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
