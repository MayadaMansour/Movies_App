import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

class MovieItem extends StatelessWidget {
  MovieItem({super.key});


  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            color: ColorResources.bgItem,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: -10,
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
    );
  }
}
