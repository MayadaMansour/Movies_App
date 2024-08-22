import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';

import '../../../model/movies_home_model/top_rated_movies_model.dart';

abstract class MoviesHomeRemoteDataSource {
  Future<TopRatedMoviesModel>? getTopRatedMovies();

  Future<UpComingMoviesModel>? getUpComingMovies();
}

abstract class MoviesHomeOfflineDataSource {}

abstract class MoviesHomeCachingDataSource {}
