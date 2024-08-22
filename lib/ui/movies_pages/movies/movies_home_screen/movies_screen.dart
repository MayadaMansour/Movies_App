import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/movie_section.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/recomended_section.dart';

import '../../../../core/model/movies_home_model/top_rated_movies_model.dart';
import '../widgets/slider_section.dart';

class MoviesScreen extends StatelessWidget {
  final List<ResultsTopRated> topRatedMovies;

  const MoviesScreen({super.key, required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SliderPannar(),
            const SizedBox(
              height: 20,
            ),
            MovieScreenSection(
              title: 'New Releases',
            ),
            const SizedBox(
              height: 25,
            ),
            RecomendedScreenSection(
              title: 'Recomended',
              time: '2018  R  1h 59m',
              rate: '7.7',
              movieName: 'Deadpool 2',
            ),
          ],
        ),
      ),
    );
  }

}
