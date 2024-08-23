import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/ui/movies_pages/browse/genres_movies/cubit/genres_state.dart';

import '../../../../../core/network/api_manage.dart';

class GenresMoviesScreenViewModel extends Cubit<GenresState> {
  GenresMoviesScreenViewModel() : super(GenresLoadingState());

//todo: hold data - handel logic

  void getGenresMovies() async {
    emit(GenresLoadingState());
    try {
      final response = await ApiManager.getGenresMovies();
      emit(GenresLoadedState(response.genres ?? []));
    } catch (e) {
      emit(GenresErrorState('Something went wrong: $e'));
    }
  }
}
