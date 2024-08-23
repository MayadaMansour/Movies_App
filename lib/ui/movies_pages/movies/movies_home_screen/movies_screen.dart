import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/home_widget/movie_section.dart';

import '../widgets/home_widget/recomended_section.dart';
import '../widgets/home_widget/slider_section.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: const SliderPannar(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: MovieScreenSection(),
          ),
          const SizedBox(height: 25),
          const RecomendedScreenSection(
            title: 'Recomended',
          ),
        ],
      ),
    ));
  }
}
