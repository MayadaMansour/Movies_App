import 'package:flutter/material.dart';

import '../../../utils/color_resource/color_resources.dart';

class DiscoverMovieDetailsScreen extends StatelessWidget {
  final String title;
  final String overview;
  final String? posterPath;

  const DiscoverMovieDetailsScreen({
    super.key,
    required this.title,
    required this.overview,
    this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: ColorResources.bgColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (posterPath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500$posterPath',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * .6,
                    width: double.infinity,
                  ),
                ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Text(
                overview,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 19),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
