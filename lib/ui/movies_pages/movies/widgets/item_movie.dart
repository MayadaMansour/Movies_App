import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';
import '../../../../core/model/movies_home_model/up_coming_movie_model.dart';
import '../movies_home_screen/details_movie_screen.dart';

class MovieCard extends StatefulWidget {
  final String imageUrl;
  final ResultsUpComing? movie;

  MovieCard({required this.imageUrl, this.movie, super.key});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
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
    );
  }
}
