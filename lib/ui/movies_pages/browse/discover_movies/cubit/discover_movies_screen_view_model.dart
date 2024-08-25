import 'package:bloc/bloc.dart';
import 'package:moves_app_project/core/model/browse_categories_model/discover_movies_model.dart';
import 'package:moves_app_project/core/network/api_manage.dart';

part 'discover_movies_state.dart';

class DiscoverMoviesScreenViewModel extends Cubit<DiscoverMoviesState> {
  final int genreId;

  DiscoverMoviesScreenViewModel(this.genreId)
      : super(DiscoverMoviesLoadingState());

  Future<void> getDiscoverMovies() async {
    emit(DiscoverMoviesLoadingState());
    try {
      final movies = await ApiManager.getMovieDiscover(genreId);
      emit(DiscoverMoviesLoadedState(movies));
    } catch (e) {
      emit(DiscoverMoviesErrorState(e.toString()));
    }
  }
}
