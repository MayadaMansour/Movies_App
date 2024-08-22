import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_home_data_source.dart';
import 'package:moves_app_project/core/repositiry/movie_home/repo/movies_home_repo_contract.dart';

class MoviesHomeRepositoryImpl implements MoviesHomeRepositoryContract {
  MoviesHomeRemoteDataSource moviesHomeRemoteDataSource;

  MoviesHomeRepositoryImpl({required this.moviesHomeRemoteDataSource});

  @override
  Future<TopRatedMoviesModel>? getTopRatedMovies() {
    return moviesHomeRemoteDataSource.getTopRatedMovies();
  }
}
