import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';

import '../../../../core/model/movies_home_model/movie_vedio.dart';

abstract class MovieHomeState {}

class MovieHomeInitial extends MovieHomeState {}

// TopRatedMovies
class LoadingTopRateMovies extends MovieHomeState {}

class SuccessTopRateMovies extends MovieHomeState {
  List<ResultsTopRated> topRateMovies;

  SuccessTopRateMovies({required this.topRateMovies});
}

class ErrorTopRateMovies extends MovieHomeState {
  String error;

  ErrorTopRateMovies({required this.error});
}

// UpComingMovies
class LoadingUpComingMovies extends MovieHomeState {}

class SuccessUpComingMovies extends MovieHomeState {
  List<ResultsUpComing> upComingMovies;

  SuccessUpComingMovies({required this.upComingMovies});
}

class ErrorUpComingMovies extends MovieHomeState {
  String error;

  ErrorUpComingMovies({required this.error});
}

// UpComingMovies
class LoadingPopularMovies extends MovieHomeState {}

class SuccessPopularMovies extends MovieHomeState {
  List<ResultsPopularMovies> popularMovies;

  SuccessPopularMovies({required this.popularMovies});
}

class ErrorPopularMovies extends MovieHomeState {
  String error;

  ErrorPopularMovies({required this.error});
}

class LoadingMovieTrailer extends MovieHomeState {}

class SuccessMovieTrailer extends MovieHomeState {
  final MovieTrailer trailer;

  SuccessMovieTrailer({required this.trailer});
}

class ErrorMovieTrailer extends MovieHomeState {
  final String error;

  ErrorMovieTrailer({required this.error});
}