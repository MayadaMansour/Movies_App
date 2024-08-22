import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../../../../core/model/movies_home_model/top_rated_movies_model.dart';
import '../widgets/details_section.dart';
import '../widgets/recomended_section.dart';

class DetailsMovie extends StatelessWidget {
  final ResultsTopRated movie;

  const DetailsMovie({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title ?? 'Movie Details'),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_sharp,
              color: ColorResources.white,
            )),
        backgroundColor: ColorResources.navBar,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Dora and the lost city of gold",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorResources.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // Add padding for better layout
              child: Text(
                "2019  PG-13  2h 7m",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorResources.grey),
              ),
            ),
            const SizedBox(height: 20),
            DetailsSection(
                typeMovie: 'Action',
                description:
                    "Having spent most of her life exploring the jungle, nothing could prepare Dora for her most dangerous adventure yet — high school.",
                rate: '7.7'),
            const SizedBox(height: 25),
            RecomendedScreenSection(
              title: 'More Like This',
              time: '2018  R  1h 59m',
              rate: '7.7',
              movieName: 'Deadpool 2',
            )
          ],
        ),
      ),
    );
  }
}
