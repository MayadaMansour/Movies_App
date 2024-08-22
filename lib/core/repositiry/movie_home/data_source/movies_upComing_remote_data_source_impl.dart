import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';
import 'package:moves_app_project/core/network/api_manage.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_upComing_data_source.dart';

class MoviesUpComingRemoteDataSourceImpl implements MoviesUpcomingDataSource {
  ApiManager apiManager;

  MoviesUpComingRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<UpComingMoviesModel>? getUpComingMovies() async {
    var response = await apiManager.getUpComingMovie();
    return response;
  }
}
