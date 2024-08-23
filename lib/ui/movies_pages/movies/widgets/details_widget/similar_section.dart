import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/movies_home_model/similar_movies_model.dart';
import '../../../../../core/network/constants.dart';
import '../../../../utils/color_resource/color_resources.dart';
import '../../movies_home_cubit/movie_home_cubit.dart';
import '../../movies_home_cubit/movie_home_state.dart';
import '../recommended_item.dart';

class SimilarScreenSection extends StatefulWidget {
  const SimilarScreenSection({
    super.key,
    required this.title,
    required this.movieId, // Add movieId parameter
  });

  final String title;
  final int movieId; // Add movieId parameter

  @override
  State<SimilarScreenSection> createState() => _SimilarScreenSectionState();
}

class _SimilarScreenSectionState extends State<SimilarScreenSection> {
  late MovieHomeCubit cubit = MovieHomeCubit();

  @override
  void initState() {
    super.initState();
    cubit.getSimilarMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieHomeCubit, MovieHomeState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is LoadingSimilarMovies) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorSimilarMovies) {
          return Center(
            child: Text('Error: ${state.error}'),
          );
        }
        if (state is SuccessSimilarMovies) {
          final movies = state.similarMovies;
          if (movies.isEmpty) {
            return const Center(
              child: Text('No movies available'),
            );
          }
          return buildMoviesList(context, movies);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget buildMoviesList(
      BuildContext context, List<ResultsSimilarMovie> movies) {
    return Container(
      color: ColorResources.bgSections,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: ColorResources.white),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  String imageUrl = movie.backdropPath != null
                      ? ApiConstants.imageUrl(movie.backdropPath!)
                      : 'https://via.placeholder.com/500';

                  return RecommendedItem(
                    img: imageUrl,
                    rate: movie.voteAverage ?? 0.0,
                    titleMovie: movie.title ?? "No Title",
                    date: movie.releaseDate ?? "No Release Date",
                  );
                },
                itemCount: movies.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 15);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
