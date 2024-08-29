import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/color_resource/color_resources.dart';
import '../../movies/movies_home_screen/details_movie_screen.dart';
import 'cubit/discover_movies_screen_view_model.dart';

class DiscoverMoviesScreen extends StatefulWidget {
  final int genreId;
  final String title;

  DiscoverMoviesScreen({required this.genreId, required this.title});

  @override
  State<DiscoverMoviesScreen> createState() => _DiscoverMoviesScreenState();
}

class _DiscoverMoviesScreenState extends State<DiscoverMoviesScreen> {
  late DiscoverMoviesScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = DiscoverMoviesScreenViewModel(widget.genreId);
    viewModel.getDiscoverMovies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorResources.bgColor,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 27,
              ),
        ),
        iconTheme: IconThemeData(color: ColorResources.white),
        backgroundColor: ColorResources.bgColor,
      ),
      body: BlocBuilder<DiscoverMoviesScreenViewModel, DiscoverMoviesState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is DiscoverMoviesLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorResources.yellow,
              ),
            );
          } else if (state is DiscoverMoviesErrorState) {
            return Column(
              children: [
                Text(state.errorMessage),
                ElevatedButton(
                    onPressed: () {
                      viewModel.getDiscoverMovies();
                    },
                    child: Text('Try Again')),
              ],
            );
          } else if (state is DiscoverMoviesLoadedState) {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: state.movies.results!.length,
              itemBuilder: (context, index) {
                var movie = state.movies.results![index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailsMovie(movieId: movie.id ?? 0)));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        movie.posterPath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width: width * .4,
                                  height: width * .6,
                                ),
                              )
                            : SizedBox(
                                width: width * .4,
                                height: width * .6,
                                child: Center(
                                    child: Icon(Icons.image_not_supported)),
                              ),
                        SizedBox(width: width * .02),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: height * 0.03,
                                horizontal: width * 0.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(height: height * .03),
                                Text(
                                  movie.releaseDate ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: ColorResources.grey),
                                ),
                                SizedBox(height: height * .016),
                                Text(
                                  'Language  ${movie.originalLanguage}' ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: ColorResources.grey,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'No Data Available',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
        },
      ),
    );
  }
}
