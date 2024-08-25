import 'package:cached_network_image/cached_network_image.dart';
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  trailer != null && trailer.key != null
                      ? CachedNetworkImage(
                    imageUrl: ApiConstants.imageUrl(trailer.key!),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) {
                      print('Failed to load image: ${ApiConstants.imageUrl(trailer.key!)}');
                      return const Icon(Icons.error);
                    },
                    fit: BoxFit.cover,
                  )
                      : const Image(
                    image: AssetImage('assets/placeholder_image.png'),
                    fit: BoxFit.cover,
                  ),
                  if (trailer != null)
                    Positioned.fill(
                      child: VideoPlayerWidget(
                        videoUrl: ApiConstants.videoUrl(trailer.key!),
                      ),
                    ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

