import 'package:flutter/material.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../item_movie.dart';

class DetailsSection extends StatelessWidget {
  final String typeMovie;
  final String description;
  final String rate;

  final ResultsUpComing? upComing;

  const DetailsSection({
    super.key,
    required this.typeMovie,
    required this.description,
    required this.rate,
    this.upComing,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        upComing?.backdropPath ?? "https://via.placeholder.com/500";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: MovieCard(
            movie: upComing,
            imageUrl: imageUrl,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: ColorResources.white),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    typeMovie,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorResources.white),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorResources.white, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorResources.yellow,
                      size: 30,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rate,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: ColorResources.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
