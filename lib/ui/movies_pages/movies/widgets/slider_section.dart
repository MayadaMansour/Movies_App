import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_cubit.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_state.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_screen/details_movie_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/model/movies_home_model/top_rated_movies_model.dart';
import '../../../../core/network/constants.dart';

class SliderPannar extends StatelessWidget {
  const SliderPannar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieHomeCubit, MovieHomeState>(
      builder: (context, state) {
        if (state is LoadingTopRateMovies) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorTopRateMovies) {
          return Center(child: Text(state.error));
        }
        if (state is SuccessTopRateMovies) {
          return CarouselSlider.builder(
            itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                addSliderMovies(
              context,
              state.topRateMovies[index],
            ),
            itemCount: state.topRateMovies.length,
            options: CarouselOptions(
              height: 200,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
            ),
          );
        }
        return Container();
      },
    );
  }
}

Widget addSliderMovies(BuildContext context, ResultsTopRated movie) {
  String imageUrl = movie.backdropPath != null
      ? ApiConstants.imageUrl(movie.backdropPath!)
      : 'https://via.placeholder.com/500';

  return Container(
    padding: const EdgeInsets.only(right: 8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsMovie(movie: movie),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: CachedNetworkImage(
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[850]!,
            highlightColor: Colors.grey[800]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    ),
  );
}
