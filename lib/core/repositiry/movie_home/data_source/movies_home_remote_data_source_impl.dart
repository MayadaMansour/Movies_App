import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
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
}
