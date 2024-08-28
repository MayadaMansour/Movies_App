import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_cubit.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_state.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/recommended_item.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../../../../../core/model/movies_home_model/popular_movie_model.dart';
import '../../../../../core/network/constants.dart';
import '../../movies_home_screen/details_movie_screen.dart';

class RecomendedScreenSection extends StatefulWidget {
  const RecomendedScreenSection({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<RecomendedScreenSection> createState() =>
      _RecomendedScreenSectionState();
}

class _RecomendedScreenSectionState extends State<RecomendedScreenSection> {
  late MovieHomeCubit cubit;

  @override
  void initState() {
    cubit = MovieHomeCubit();
    cubit.getTopRateMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => cubit,
        child: BlocBuilder<MovieHomeCubit, MovieHomeState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is LoadingTopRateMovies) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ErrorTopRateMovies) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            }
            if (state is SuccessTopRateMovies) {
              final movies = state.topRateMovies;
              if (movies.isEmpty) {
                return const Center(
                  child: Text('No movies available'),
                );
              }
              return buildMoviesList(context, movies);
            }
            return const SizedBox.shrink();
          },
        ));
  }

  Widget buildMoviesList(BuildContext context, List<ResultsTopRated> movies) {
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

                  return InkWell(
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
                    child: RecommendedItem(
                      img: imageUrl,
                      rate: movie.voteAverage,
                      titleMovie: movie.title ?? "No Title",
                      date: movie.releaseDate ?? "No Release Date",
                      movie: convertToPopularMovies(movie), // Convert here
                    ),
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

  ResultsPopularMovies convertToPopularMovies(ResultsTopRated topRated) {
    return ResultsPopularMovies(
      id: topRated.id,
      title: topRated.title,
      backdropPath: topRated.backdropPath,
      voteAverage: topRated.voteAverage,
      releaseDate: topRated.releaseDate,
    );
  }
}
