import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/vedio_player.dart';

import '../../../../core/network/constants.dart';
import '../movies_home_cubit/movie_home_cubit.dart';
import '../movies_home_cubit/movie_home_state.dart';

class VideoItem extends StatefulWidget {
  final int movieId;

  const VideoItem({super.key, required this.movieId});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late MovieHomeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = MovieHomeCubit();
    cubit.getMovieTrailer(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<MovieHomeCubit, MovieHomeState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is LoadingMovieTrailer) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (state is ErrorMovieTrailer) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is SuccessMovieTrailer) {
            final trailer = state.trailer.trailers?.isNotEmpty == true
                ? state.trailer.trailers![0]
                : null;

            return Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: trailer != null && trailer.key != null
                      ? NetworkImage(
                          ApiConstants.imageUrl(trailer.key!),
                          scale: 1.0,
                        )
                      : const AssetImage('assets/placeholder_image.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: trailer != null
                  ? VideoPlayerWidget(
                      videoUrl: ApiConstants.videoUrl(trailer.key!))
                  : null,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
