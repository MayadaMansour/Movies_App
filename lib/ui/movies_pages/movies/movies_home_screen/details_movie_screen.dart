import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/core/model/movies_home_model/details_move_model.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_cubit.dart';
import 'package:moves_app_project/ui/movies_pages/movies/movies_home_cubit/movie_home_state.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../widgets/details_widget/details_section.dart';
import '../widgets/details_widget/similar_section.dart';
import '../widgets/video_item.dart';

class DetailsMovie extends StatefulWidget {
  final int movieId;

  DetailsMovie({Key? key, required this.movieId}) : super(key: key);

  @override
  State<DetailsMovie> createState() => _DetailsMovieState();
}

class _DetailsMovieState extends State<DetailsMovie> {
  late MovieHomeCubit cubit = MovieHomeCubit();

  @override
  void initState() {
    super.initState();
    cubit.getDetailsMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieHomeCubit, MovieHomeState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is LoadingDetailsMovies) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessDetailsMovies) {
          final movie = state.detailsMovieModel;
          final genre = movie?.genres != null && movie!.genres!.isNotEmpty
              ? movie.genres![0].name ?? 'Unknown Genre'
              : 'Unknown Genre';
          final description = movie?.overview ?? 'No Description Available';
          final title = movie?.title ?? 'No Title Available';
          final rating = movie?.voteAverage?.toString() ?? 'N/A';
          final movieId = movie?.id ?? 0;

          return Scaffold(
            backgroundColor: ColorResources.bgColor,
            appBar: AppBar(
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: ColorResources.white,
                ),
              ),
              backgroundColor: ColorResources.navBar,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VideoItem(movieId: movieId),
                  const SizedBox(height: 30),
                  DetailsSection(
                    typeMovie: genre,
                    description: description,
                    rate: rating,
                    details: movie,
                  ),
                  const SizedBox(height: 25),
                  SimilarScreenSection(
                    title: 'More Like This',
                    movieId: movieId,
                  ),
                ],
              ),
            ),
          );
        } else if (state is ErrorDetailsMovies) {
          return Center(
            child: Text(
              'Error: ${state.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return Container();
      },
    );
  }
}

