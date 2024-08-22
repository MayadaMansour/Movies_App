import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;

  const MovieCard({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          // Handle onTap
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.3,
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.bookmark,
                    color: ColorResources.grey.withOpacity(0.6),
                    size: 55,
                  ),
                  Icon(
                    Icons.add,
                    color: ColorResources.white,
                    size: 20,
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

