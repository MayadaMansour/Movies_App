import 'package:flutter/material.dart';

import '../../../utils/color_resource/color_resources.dart';
import '../widgets/recomended_section.dart';

class DetailsMovie extends StatelessWidget {
  const DetailsMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
              "Dora and the lost city of gold",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorResources.white),
            ),
            Text(
              "2019  PG-13  2h 7m",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: ColorResources.grey),
            ),


            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 25,
            ),
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
