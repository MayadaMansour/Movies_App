import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_cubit.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_state.dart';

import '../../../../core/model/movies_home_model/top_rated_movies_model.dart';
import '../../../../core/network/constants.dart';

class SliderPannar extends StatelessWidget {
  const SliderPannar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieHomeCubit, MovieHomeState>(
      builder: (context, state) {
        if (state is LoadingTopRateMovies) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (state is ErrorTopRateMovies) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is SuccessTopRateMovies) {
          final movies = state.topRateMovies;

          return CarouselSlider.builder(
            itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                addSliderMovie(movies[index], context),
            itemCount: movies.length,
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
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Widget addSliderMovie(ResultsTopRated movie, BuildContext context) {
  String imageUrl = movie.backdropPath != null
      ? ApiConstants.imageUrl(movie.backdropPath!)
      : 'https://via.placeholder.com/500';

  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Text(
          movie.title ?? 'No Title',
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
