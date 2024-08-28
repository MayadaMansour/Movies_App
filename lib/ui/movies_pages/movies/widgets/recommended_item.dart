import 'package:flutter/material.dart';
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/core/firebase_utils/firebase_data.dart';
import '../../../utils/color_resource/color_resources.dart';

class RecommendedItem extends StatefulWidget {
  const RecommendedItem({
    required this.img,
    required this.rate,
    required this.titleMovie,
    required this.date,
    required this.movie,
    super.key,
  });

  final String img;
  final double? rate;
  final String titleMovie;
  final String date;
  final ResultsPopularMovies movie;

  @override
  State<RecommendedItem> createState() => _RecommendedItemState();
}

class _RecommendedItemState extends State<RecommendedItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Card(
        color: ColorResources.bgItem,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.img.isNotEmpty
                            ? widget.img
                            : 'default_image_url'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -7,
                  left: -12,
                  child: InkWell(
                    onTap: () {
                      if (widget.movie != null) {
                        setState(() {
                          isSelected = !isSelected;
                        });
                        if (isSelected) {
                          addUPopularMovieToWatchlist(widget.movie);
                        } else {
                          removeMovieFromWatchlist(widget.movie.id.toString());
                        }
                      } else {
                        print('Movie is null');
                      }
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: ColorResources.yellow,
                      ),
                      Text(
                        (widget.rate ?? 0.0).toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorResources.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.titleMovie.isNotEmpty
                        ? widget.titleMovie
                        : "No Title",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorResources.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.date.isNotEmpty ? widget.date : "No Release Date",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorResources.white, fontSize: 15),
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
