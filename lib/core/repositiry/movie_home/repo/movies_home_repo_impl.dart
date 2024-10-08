import 'package:moves_app_project/core/model/movies_home_model/details_move_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/movie_vedio.dart';
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/similar_movies_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_home_data_source.dart';
import 'package:moves_app_project/core/repositiry/movie_home/repo/movies_home_repo_contract.dart';

import '../../../model/movies_home_model/up_coming_movie_model.dart';

class MoviesHomeRepositoryImpl implements MoviesHomeRepositoryContract {
  MoviesHomeRemoteDataSource moviesHomeRemoteDataSource;

  MoviesHomeRepositoryImpl({required this.moviesHomeRemoteDataSource});

  @override
  Future<TopRatedMoviesModel>? getTopRatedMovies() {
    return moviesHomeRemoteDataSource.getTopRatedMovies();
  }

  @override
  Future<UpComingMoviesModel>? getUpComingMovies() {
    return moviesHomeRemoteDataSource.getUpComingMovies();
  }

  @override
  Future<PopularMovieModel>? getPopularMovies() {
    return moviesHomeRemoteDataSource.getPopularMovies();
  }

  @override
  Future<MovieTrailer>? getVideoMovies(int id) {
    return moviesHomeRemoteDataSource.getVideoMovies(id);
  }

  @override
  Future<SimilarMovieModel>? getSimilarMovies(int id) {
    return moviesHomeRemoteDataSource.getSimilarMovies(id);
  }

  @override
  Future<DetailsMovieModel>? getDetailsMovies(int id) {
    return moviesHomeRemoteDataSource.getDetailsMovies(id);

  }
}
