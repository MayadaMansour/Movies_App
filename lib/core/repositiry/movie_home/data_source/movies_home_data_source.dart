import 'package:moves_app_project/core/model/movies_home_model/movie_vedio.dart';
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';

import '../../../model/movies_home_model/top_rated_movies_model.dart';

abstract class MoviesHomeRemoteDataSource {
  Future<TopRatedMoviesModel>? getTopRatedMovies();

  Future<UpComingMoviesModel>? getUpComingMovies();

  Future<PopularMovieModel>? getPopularMovies();

  Future<MovieTrailer>? getVideoMovies(int id);
}

abstract class MoviesHomeOfflineDataSource {}

abstract class MoviesHomeCachingDataSource {}
