import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/movie_section.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/recomended_section.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            addSliderMovies(context),
            const SizedBox(
              height: 20,
            ),
            MovieScreenSection(
              title: 'New Releases ',
            ),
            const SizedBox(
              height: 25,
            ),
            RecomendedScreenSection(
              title: 'Recomended',
              time: '2018  R  1h 59m',
              rate: '7.7',
              movieName: 'Deadpool 2',
            )
          ],
        ),
      ),
    );
  }

  Widget addSliderMovies(context) {
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
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'text $i',
                style: const TextStyle(fontSize: 16.0),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
