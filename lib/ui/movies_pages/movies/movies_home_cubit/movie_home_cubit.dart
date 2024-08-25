import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';
import 'package:moves_app_project/core/network/api_manage.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_home_data_source.dart';
import 'package:moves_app_project/core/repositiry/movie_home/data_source/movies_home_remote_data_source_impl.dart';
import 'package:moves_app_project/core/repositiry/movie_home/repo/movies_home_repo_contract.dart';
import 'package:moves_app_project/core/repositiry/movie_home/repo/movies_home_repo_impl.dart';

import '../../../../core/model/movies_home_model/movie_vedio.dart';
import 'movie_home_state.dart';

class MovieHomeCubit extends Cubit<MovieHomeState> {
  late MoviesHomeRepositoryContract moviesHomeRepositoryContract;
  late MoviesHomeRemoteDataSource moviesHomeRemoteDataSource;

  late ApiManager apiManager;
  List<ResultsUpComing> upComing = [];

  MovieHomeCubit() : super(MovieHomeInitial()) {
    apiManager = ApiManager();
    moviesHomeRemoteDataSource =
        MoviesHomeRemoteDataSourceImpl(apiManager: apiManager);
    moviesHomeRepositoryContract = MoviesHomeRepositoryImpl(
        moviesHomeRemoteDataSource: moviesHomeRemoteDataSource);
  }

  static MovieHomeCubit get(context) => BlocProvider.of(context);

  void getPopularMovies() async {
    emit(LoadingPopularMovies());
    try {
      final movies = await moviesHomeRepositoryContract.getPopularMovies();
      if (movies == null || movies.results == null) {
        emit(SuccessPopularMovies(popularMovies: []));
      } else {
        emit(SuccessPopularMovies(popularMovies: movies.results!));
      }
    } catch (error) {
      emit(ErrorPopularMovies(error: error.toString()));
    }
  }

  void getMovieTrailer(int id) async {
    emit(LoadingMovieTrailer());
    try {
      final trailerResponse =
          await moviesHomeRepositoryContract.getVideoMovies(id);
      if (trailerResponse == null ||
          trailerResponse.trailers == null ||
          trailerResponse.trailers!.isEmpty) {
        emit(ErrorMovieTrailer(error: 'Trailer not found'));
      } else {
        final movieTrailer = MovieTrailer(
          id: id,
          trailers: trailerResponse.trailers,
        );
        emit(SuccessMovieTrailer(trailer: movieTrailer));
      }
    } catch (error) {
      print(error);
      emit(ErrorMovieTrailer(error: error.toString()));
    }
  }

  void getUpComingMovies() async {
    emit(LoadingUpComingMovies());
    try {
      final movies = await moviesHomeRepositoryContract.getUpComingMovies();
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

  void getSimilarMovies(int movieId) async {
    emit(LoadingSimilarMovies());
    try {
      final movies = await moviesHomeRepositoryContract.getSimilarMovies(movieId);
      print('Response: ${movies.toString()}');
      if (movies == null || movies.results == null) {
        emit(SuccessSimilarMovies(similarMovies: []));
      } else {
        emit(SuccessSimilarMovies(similarMovies: movies.results!));
      }
    } catch (error, stackTrace) {
      print("Error fetching similar movies: $error");
      print("Stack trace: $stackTrace");
      emit(ErrorSimilarMovies(error: error.toString()));
    }
  }


  void getDetailsMovies(int movieId) async {
    emit(LoadingDetailsMovies());
    try {
      final movie =
      await moviesHomeRepositoryContract.getDetailsMovies(movieId);
      if (movie == null) {
        emit(ErrorDetailsMovies(error: "Movie not found"));
      } else {
        emit(SuccessDetailsMovies(detailsMovieModel: movie));
      }
    } catch (error) {
      emit(ErrorDetailsMovies(error: error.toString()));
    }
  }}
