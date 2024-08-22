import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';
import 'package:moves_app_project/core/network/api_manage.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_home_data_source.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_home_remote_data_source_impl.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_upComing_data_source.dart';
import 'package:moves_app_project/core/repositiry/movie_home/repo/movies_home_repo_contract.dart';
import 'package:moves_app_project/core/repositiry/movie_home/repo/movies_home_repo_impl.dart';
import 'package:moves_app_project/core/repositiry/movie_home/repo/movies_upComing_repo_contract.dart';

import '../../../../core/repositiry/movie_home/data_source/movies_upComing_remote_data_source_impl.dart';
import '../../../../core/repositiry/movie_home/repo/movies_upComing_repo_impl.dart';
import 'movie_home_state.dart';

class MovieHomeCubit extends Cubit<MovieHomeState> {
  late MoviesHomeRepositoryContract moviesHomeRepositoryContract;
  late MoviesHomeRemoteDataSource moviesHomeRemoteDataSource;
  late MoviesUpcomingRepoContract moviesUpcomingRepoContract;
  late MoviesUpcomingDataSource moviesUpcomingDataSource;
  late ApiManager apiManager;
  List<ResultsTopRated>? topRateMovies;
  List<ResultsUpComing>? upComingMovies;

  MovieHomeCubit() : super(MovieHomeInitial()) {
    apiManager = ApiManager();
    moviesHomeRemoteDataSource =
        MoviesHomeRemoteDataSourceImpl(apiManager: apiManager);
    moviesHomeRepositoryContract = MoviesHomeRepositoryImpl(
        moviesHomeRemoteDataSource: moviesHomeRemoteDataSource);
    moviesUpcomingDataSource =
        MoviesUpComingRemoteDataSourceImpl(apiManager: apiManager);
    moviesUpcomingRepoContract = MoviesUpComingRepositoryImpl(
        moviesUpcomingDataSource: moviesUpcomingDataSource);
  }

  static MovieHomeCubit get(context) => BlocProvider.of(context);

  void getPopularMovies() {}

  void getUpComingMovies() async {
    emit(LoadingUpComingMovies());
    try {
      final movies = await moviesUpcomingRepoContract.getUpComingMovies();
      if (movies == null || movies.results == null) {
        emit(SuccessUpComingMovies(upComingMovies: []));
      } else {
        emit(SuccessUpComingMovies(upComingMovies: movies.results!));
      }
    } catch (error) {
      emit(ErrorUpComingMovies(error: error.toString()));
    }
  }

  void getTopRateMovies() async {
    emit(LoadingTopRateMovies());
    try {
      final movies = await moviesHomeRepositoryContract.getTopRatedMovies();
      if (movies == null || movies.results == null) {
        emit(SuccessTopRateMovies(topRateMovies: []));
      } else {
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
