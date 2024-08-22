import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';

abstract class MovieHomeState {}

class MovieHomeInitial extends MovieHomeState {}

//UpComingMovies
class LoadingUpComingMovies extends MovieHomeState {}

class SuccessUpComingMovies extends MovieHomeState {}

class ErrorUpComingMovies extends MovieHomeState {}

//TopRateMovies
class LoadingTopRateMovies extends MovieHomeState {}

class SuccessTopRateMovies extends MovieHomeState {
  List<ResultsTopRated> topRateMovies;

  SuccessTopRateMovies({required this.topRateMovies});
}

class ErrorTopRateMovies extends MovieHomeState {
  String error;

  ErrorTopRateMovies({required this.error});
}

//PopularMovies
class LoadingPopularMovies extends MovieHomeState {}

class SuccessPopularMovies extends MovieHomeState {}

class ErrorPopularMovies extends MovieHomeState {}

//DetailsMovie
class LoadingDetailsMovie extends MovieHomeState {}

class SuccessDetailsMovie extends MovieHomeState {}

class ErrorDetailsMovie extends MovieHomeState {}

//SimilarMovie
class LoadingSimilarMovies extends MovieHomeState {}

class SuccessSimilarMovies extends MovieHomeState {}

class ErrorSimilarMovies extends MovieHomeState {}
