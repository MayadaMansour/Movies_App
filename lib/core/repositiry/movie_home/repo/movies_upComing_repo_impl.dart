import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_upComing_data_source.dart';
import 'package:moves_app_project/core/repositiry/movie_home/repo/movies_upComing_repo_contract.dart';

class MoviesUpComingRepositoryImpl implements MoviesUpcomingRepoContract {
  MoviesUpcomingDataSource moviesUpcomingDataSource;

  MoviesUpComingRepositoryImpl({required this.moviesUpcomingDataSource});

  @override
  Future<UpComingMoviesModel>? getUpComingMovies() {
    return moviesUpcomingDataSource.getUpComingMovies();
  }
}
