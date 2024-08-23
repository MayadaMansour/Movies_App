import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../../../../core/model/movies_home_model/up_coming_movie_model.dart';
import '../widgets/details_widget/details_section.dart';
import '../widgets/details_widget/similar_section.dart';
import '../widgets/video_item.dart';

class DetailsMovie extends StatelessWidget {
  final ResultsUpComing movie;

  DetailsMovie({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.bgColor,
      appBar: AppBar(
        title: Text(
          movie.title ?? 'Movie Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: ColorResources.white,
          ),
        ),
        backgroundColor: ColorResources.navBar,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (movie.id != null) VideoItem(movieId: movie.id!),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title ?? 'Unknown Title',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorResources.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.releaseDate ?? 'Unknown Date',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorResources.grey),
              ),
            ),
            const SizedBox(height: 20),
            DetailsSection(
              typeMovie: "movie",
              description: movie.overview ?? 'No Description Available',
              rate: movie.voteAverage?.toString() ?? 'N/A',
            ),
            const SizedBox(height: 25),
            SimilarScreenSection(
              title: 'More Like This',
              movieId: movie.id ?? 0,
            ),
          ],
        ),
      ),
    );
  }
}
