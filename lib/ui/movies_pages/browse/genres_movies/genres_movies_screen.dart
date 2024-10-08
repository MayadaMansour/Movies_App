import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moves_app_project/ui/movies_pages/browse/genres_movies/cubit/genres_movies_screen_view_model.dart';
import 'package:moves_app_project/ui/movies_pages/browse/genres_movies/cubit/genres_state.dart';

import '../../../utils/color_resource/color_resources.dart';
import '../browse_category_item.dart';

class GenresMoviesScreen extends StatefulWidget {
  @override
  State<GenresMoviesScreen> createState() => _GenresMoviesScreenState();
}

class _GenresMoviesScreenState extends State<GenresMoviesScreen> {
  GenresMoviesScreenViewModel viewModel = GenresMoviesScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getGenresMovies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<GenresMoviesScreenViewModel, GenresState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is GenresLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorResources.yellow),
          );
        } else if (state is GenresErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.errorMessage),
              ElevatedButton(
                onPressed: () {
                  viewModel.getGenresMovies();
                },
                child: Text('Try Again'),
              ),
            ],
          );
        } else if (state is GenresLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: (state.listGenres.length / 2).ceil(),
              itemBuilder: (context, index) {
                int firstIndex = index * 2;
                int secondIndex = firstIndex + 1;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height*.014),
                  child: Row(
                    children: [
                      Expanded(
                        child: BrowseCategoryItem(
                            title: state.listGenres[firstIndex].name ?? '',
                            imagePath: 'assets/images/image.jpg',
                            genresId: state.listGenres[firstIndex].id!),
                      ),
                      SizedBox(width: width * .04),
                      if (secondIndex < state.listGenres.length)
                        Expanded(
                          child: BrowseCategoryItem(
                            title: state.listGenres[secondIndex].name ?? '',
                            imagePath: 'assets/images/image.jpg',
                            genresId: state.listGenres[secondIndex].id!,
                          ),
                        ),
                      if (secondIndex >= state.listGenres.length)
                        Expanded(child: SizedBox.shrink()),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: Text('No Data Available'));
        }
      },
    );

  }
}