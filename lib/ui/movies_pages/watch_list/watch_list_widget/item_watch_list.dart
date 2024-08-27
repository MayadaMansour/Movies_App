import 'package:flutter/material.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';
import 'package:moves_app_project/ui/movies_pages/watch_list/watch_list_widget/watch_list_model.dart';

import '../../../../core/network/constants.dart';
import '../../../utils/color_resource/color_resources.dart';
import '../../movies/movies_home_screen/details_movie_screen.dart';
import '../../movies/widgets/item_movie.dart';

class ItemWatchList extends StatefulWidget {
  ResultsUpComing model;

  ItemWatchList({Key? key, required this.model}) : super(key: key);

  @override
  State<ItemWatchList> createState() => _ItemWatchListState();
}

class _ItemWatchListState extends State<ItemWatchList> {
  List<ResultsUpComing>? upComingMovies;
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final String fullImageUrl =
        'https://image.tmdb.org/t/p/original/${widget.model.backdropPath}';

    return Padding(
      padding: EdgeInsets.all(height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(fullImageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                top: -7,
                left: -12,
                child: InkWell(
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
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.03, horizontal: width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorResources.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.model.releaseDate.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: ColorResources.white),
                  ),
                  Text(
                    widget.model.voteCount!.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: ColorResources.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
