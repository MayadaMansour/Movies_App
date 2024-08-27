import 'package:flutter/material.dart';
import 'package:moves_app_project/core/model/movies_home_model/details_move_model.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../item_movie.dart';

class DetailsSection extends StatefulWidget {
  final String typeMovie;
  final String description;
  final String rate;
  final DetailsMovieModel? details;

  const DetailsSection({
    super.key,
    required this.typeMovie,
    required this.description,
    required this.rate,
    this.details,
  });

  @override
  State<DetailsSection> createState() => _DetailsSectionState();
}

class _DetailsSectionState extends State<DetailsSection> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.details?.backdropPath != null
        ? 'https://image.tmdb.org/t/p/original/${widget.details!.backdropPath}'
        : "https://via.placeholder.com/500";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              top: -7,
              left: -12,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: isSelected
                          ? ColorResources.yellow.withOpacity(0.6)
                          : ColorResources.grey.withOpacity(0.6),
                      size: 55,
                    ),
                    Icon(
                      isSelected ? Icons.check : Icons.add,
                      color: ColorResources.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: ColorResources.white),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    widget.typeMovie,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorResources.white),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorResources.white, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorResources.yellow,
                      size: 25,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.rate,
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

