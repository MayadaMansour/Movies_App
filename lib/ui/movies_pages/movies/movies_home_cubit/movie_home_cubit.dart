import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
import 'package:moves_app_project/core/network/api_manage.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_home_data_source.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_home_remote_data_source_impl.dart';
import 'package:moves_app_project/core/repositiry/movie_home/repo/movies_home_repo_contract.dart';
import 'package:moves_app_project/core/repositiry/movie_home/repo/movies_home_repo_impl.dart';

import 'movie_home_state.dart';

class MovieHomeCubit extends Cubit<MovieHomeState> {
  late MoviesHomeRepositoryContract moviesHomeRepositoryContract;
  late MoviesHomeRemoteDataSource moviesHomeRemoteDataSource;
  late ApiManager apiManager;
  List<ResultsTopRated>? topRateMovies;

  MovieHomeCubit() : super(MovieHomeInitial()) {
    apiManager = ApiManager();
    moviesHomeRemoteDataSource =
        MoviesHomeRemoteDataSourceImpl(apiManager: apiManager);
    moviesHomeRepositoryContract = MoviesHomeRepositoryImpl(
        moviesHomeRemoteDataSource: moviesHomeRemoteDataSource);
  }

  static MovieHomeCubit get(context) => BlocProvider.of(context);

  void getPopularMovies() {}

  void getUpComingMovies() {}

  void getTopRateMovies() async {
    emit(LoadingTopRateMovies());
    try {
      final movies = await moviesHomeRepositoryContract.getTopRatedMovies();
      if (movies == null || movies.results == null) {
        emit(SuccessTopRateMovies(topRateMovies: []));
      } else {
        print("Movies fetched: ${movies.results!.length}");
        emit(SuccessTopRateMovies(topRateMovies: movies.results!));
      }
    } catch (error) {
      print("Error fetching movies: $error");
      emit(ErrorTopRateMovies(error: error.toString()));
    }
  }

  void getSimilarMovies() {}

  void getDetailsMovie() {}
}
