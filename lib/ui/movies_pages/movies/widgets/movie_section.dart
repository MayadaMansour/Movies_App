import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../movies_home_screen/details_movie_screen.dart';
import 'item_movie.dart';

class MovieScreenSection extends StatelessWidget {
  MovieScreenSection({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      color: ColorResources.bgSections,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: ColorResources.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DetailsMovie()),
                        );
                      },
                      child: MovieItem());
                },
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 15);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
