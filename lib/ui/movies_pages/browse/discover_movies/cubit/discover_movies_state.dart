part of 'discover_movies_screen_view_model.dart';

abstract class DiscoverMoviesState {}

class DiscoverMoviesLoadingState extends DiscoverMoviesState {}

class DiscoverMoviesLoadedState extends DiscoverMoviesState {
  final DiscoverMoviesModel movies;

  DiscoverMoviesLoadedState(this.movies);
}

class DiscoverMoviesErrorState extends DiscoverMoviesState {
  final String errorMessage;

  DiscoverMoviesErrorState(this.errorMessage);
}
