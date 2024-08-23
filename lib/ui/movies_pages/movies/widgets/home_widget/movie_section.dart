import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_cubit.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_state.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../../../../../core/network/constants.dart';
import '../item_movie.dart';

class MovieScreenSection extends StatefulWidget {
  MovieScreenSection({super.key});

  @override
  State<MovieScreenSection> createState() => _MovieScreenSectionState();
}

class _MovieScreenSectionState extends State<MovieScreenSection> {
  late MovieHomeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = MovieHomeCubit()..getUpComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<MovieHomeCubit, MovieHomeState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is LoadingUpComingMovies) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorUpComingMovies) {
            return Center(child: Text(state.error));
          }
          if (state is SuccessUpComingMovies) {
            final upcomingMovies = state.upComingMovies;
            if (upcomingMovies.isEmpty) {
              return const Center(child: Text('No Upcoming Movies'));
            }

            return Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: ColorResources.bgSections,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Releases",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: ColorResources.white),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final movie =
                              upcomingMovies[index]; // ResultsUpComing
                          return MovieCard(
                            imageUrl:
                                ApiConstants.imageUrl(movie.backdropPath!),
                            movie: movie, // Pass the correct type here
                          );
                        },
                        itemCount: upcomingMovies.length,
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
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
