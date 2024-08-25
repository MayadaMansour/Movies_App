import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/color_resource/color_resources.dart';
import 'cubit/discover_movies_screen_view_model.dart';
import 'discover_movies_details_screen.dart';

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
    return Scaffold(
      backgroundColor: ColorResources.bgColor,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 27,
              ),
        ),
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
              padding: EdgeInsets.all(8.0),
              itemCount: state.movies.results!.length,
              itemBuilder: (context, index) {
                var movie = state.movies.results![index];
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: movie.posterPath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * .3,
                          ),
                        )
                      : SizedBox.shrink(),
                  title: Text(
                    "${movie.title ?? ''}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      movie.overview ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiscoverMovieDetailsScreen(
                          title: movie.title ?? '',
                          overview: movie.overview ?? '',
                          posterPath: movie.posterPath,
                        ),
                      ),
                    );
                  },
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
