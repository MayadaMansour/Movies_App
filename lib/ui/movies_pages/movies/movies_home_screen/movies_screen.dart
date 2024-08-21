import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moves_app_project/core/network/constants.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/movie_section.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/recomended_section.dart';

import '../../../../core/model/movies_home_model/top_rated_movies_model.dart';

class MoviesScreen extends StatelessWidget {
  final List<ResultsTopRated> topRatedMovies;

  const MoviesScreen({super.key, required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            addSliderMovies(context, topRatedMovies),
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

  Widget addSliderMovies(BuildContext context, List<ResultsTopRated> movies) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.35,
        initialPage: 0,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
      ),
      items: movies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            String imageUrl = movie.backdropPath != null
                ? ApiConstants.imageUrl(movie.backdropPath!)
                : 'https://via.placeholder.com/500';
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                movie.title ?? 'No Title',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
