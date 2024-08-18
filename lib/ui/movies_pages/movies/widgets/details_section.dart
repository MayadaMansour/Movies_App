import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/movies_pages/movies/widgets/item_movie.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MovieItem(),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(

                border: Border.all(width: 3.0),
                borderRadius: const BorderRadius.all(Radius.circular(
                        5.0) //                 <--- border radius here
                    ),
              ),
              child: const Text("Action"),
            )
          ],
        )
      ],
    );
  }
}
