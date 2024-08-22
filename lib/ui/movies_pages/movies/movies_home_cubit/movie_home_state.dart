import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';

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
