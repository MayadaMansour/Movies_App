import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_home_state.dart';

class MovieHomeCubit extends Cubit<MovieHoneState> {
  MovieHomeCubit() : super(MovieHomeInitial());

  static MovieHomeCubit get(context) => BlocProvider.of(context);

  void getPopularMovies() {}

  void getUpComingMovies() {}

  void getTopRateMovies() {}

  void getSimilarMovies() {}

  void getDetailsMovie() {}
}
