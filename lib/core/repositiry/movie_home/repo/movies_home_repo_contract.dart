import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';

abstract class MoviesHomeRepositoryContract {
  Future<TopRatedMoviesModel>? getTopRatedMovies();
}
