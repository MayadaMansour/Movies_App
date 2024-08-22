import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';

abstract class MoviesUpcomingRepoContract {
  Future<UpComingMoviesModel>? getUpComingMovies();
}
