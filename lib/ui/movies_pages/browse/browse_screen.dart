import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/movies_pages/browse/genres_movies/genres_movies_screen.dart';

import '../../utils/color_resource/color_resources.dart';

class BrowseScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.bgColor,
      appBar: AppBar(
        title: Text(
          "Browse Category",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 27,
                ),
          ),
        backgroundColor: ColorResources.bgColor,
      ),
        body: GenresMoviesScreen()

        //GenresMoviesScreen(genres: genres,),
        );
  }
}
