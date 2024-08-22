import '../../../model/movies_home_model/top_rated_movies_model.dart';

abstract class MoviesHomeRemoteDataSource {
  Future<TopRatedMoviesModel>? getTopRatedMovies();
}

abstract class MoviesHomeOfflineDataSource {}

abstract class MoviesHomeCachingDataSource {}
