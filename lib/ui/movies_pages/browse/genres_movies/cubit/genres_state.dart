import 'package:moves_app_project/core/model/browse_categories_model/genres_movies_model.dart';

abstract class GenresState {}

class GenresLoadingState extends GenresState {}

class GenresLoadedState extends GenresState {
  final List<Genres> listGenres;

  GenresLoadedState(this.listGenres);
}

class GenresErrorState extends GenresState {
  final String errorMessage;

  GenresErrorState(this.errorMessage);
}
