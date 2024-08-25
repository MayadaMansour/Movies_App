import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/item_movie.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/video_item.dart';

import '../../../../../core/network/constants.dart';
import '../../movies_home_cubit/movie_home_cubit.dart';
import '../../movies_home_cubit/movie_home_state.dart';
import '../../movies_home_screen/details_movie_screen.dart';

class SliderPannar extends StatefulWidget {
  const SliderPannar({super.key});

  @override
  State<SliderPannar> createState() => _SliderPannarState();
}

class _SliderPannarState extends State<SliderPannar> {
  late MovieHomeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = MovieHomeCubit();
    cubit.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<MovieHomeCubit, MovieHomeState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is LoadingPopularMovies) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is ErrorPopularMovies) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is SuccessPopularMovies) {
            final movies = state.popularMovies;

            return CarouselSlider.builder(
              itemBuilder:
                  (BuildContext context, int index, int pageViewIndex) {
                return addSliderMovie(movies[index], context);
              },
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
      ),
    );
  }
}

Widget addSliderMovie(ResultsPopularMovies movie, BuildContext context) {
  final imageUrl = ApiConstants.imageUrl(movie.backdropPath);

  return Stack(
    clipBehavior: Clip.none,
    children: [
      if (movie.id != null) VideoItem(movieId: movie.id!),
      Positioned(
        left: 0,
        bottom: -25,
        child: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsMovie(
                        movieId: movie.id ?? 0,
                      ),
                    ),
                  );
                },
                child: MovieCard(imageUrl: imageUrl)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.releaseDate ?? 'No Release Date',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
