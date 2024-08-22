import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../../../../core/model/movies_home_model/up_coming_movie_model.dart';
import '../../../../core/network/constants.dart';

class MovieCard extends StatelessWidget {
  final ResultsUpComing movie;

  const MovieCard({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    // Determine image URL
    String imageUrl = movie.backdropPath != null
        ? ApiConstants.imageUrl(movie.backdropPath!)
        : 'https://via.placeholder.com/500';

    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to movie details
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DetailsMovie(movie: movie),
          //   ),
          // );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    imageUrl,
                    scale: 1.0,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
            Positioned(
              top: -7,
              left: -12,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.bookmark,
                    color: ColorResources.grey.withOpacity(0.6),
                    size: 55,
                  ),
                  Icon(
                    Icons.add,
                    color: ColorResources.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
