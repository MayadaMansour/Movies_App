import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_cubit.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_state.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../../../../core/network/constants.dart';

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
  MovieHomeCubit cubit = MovieHomeCubit();

  @override
  void initState() {
    cubit.getPopularMovies();
    super.initState();
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
                child: CircularProgressIndicator(),
              );
            }
            if (state is ErrorPopularMovies) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            }
            if (state is SuccessPopularMovies) {
              final movies = state.popularMovies;
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

  Widget buildMoviesList(
      BuildContext context, List<ResultsPopularMovies> movies) {
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

                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Card(
                      color: ColorResources.bgItem,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
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
                              Positioned(
                                top: -7,
                                left: -12,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color:
                                          ColorResources.grey.withOpacity(0.6),
                                      size: 55,
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: ColorResources.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: ColorResources.yellow,
                                    ),
                                    Text(
                                      movie.voteAverage.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: ColorResources.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  movie.title ?? "No Title",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: ColorResources.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  movie.releaseDate ?? "No Release Date",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: ColorResources.white,
                                          fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
}
