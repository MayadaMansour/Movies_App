import 'package:moves_app_project/core/model/movies_home_model/details_move_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/movie_vedio.dart';
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/similar_movies_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';
import 'package:moves_app_project/core/network/api_manage.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_home_data_source.dart';

class MoviesHomeRemoteDataSourceImpl implements MoviesHomeRemoteDataSource {
  ApiManager apiManager;

  MoviesHomeRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<TopRatedMoviesModel>? getTopRatedMovies() async {
    var response = await apiManager.getTopRateMovie();
    return response;
  }

  @override
  Future<UpComingMoviesModel>? getUpComingMovies() async {
    var response = await apiManager.getUpComingMovie();
    return response;
  }

  @override
  Future<PopularMovieModel>? getPopularMovies() async {
    var response = await apiManager.getPopularMovie();
    return response;
  }

  @override
  Future<MovieTrailer> getVideoMovies(int id) async {
    final response = await apiManager.getMovieTrailer(id);
    return response;
  }

  @override
  Future<SimilarMovieModel>? getSimilarMovies(int id) async {
    final response = await apiManager.getSimilarMovies(id);
    return response;
  }

  @override
  Future<DetailsMovieModel>? getDetailsMovies(int id) async {
    final response = await apiManager.getDetailsMovies(id);
    return response;
  }
}
