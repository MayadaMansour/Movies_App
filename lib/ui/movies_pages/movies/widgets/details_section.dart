import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

class DetailsSection extends StatelessWidget {
  DetailsSection({
    super.key,
    required this.typeMovie,
    required this.description,
    required this.rate,
  });

  String typeMovie;
  String description;
  String rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //     width: MediaQuery.of(context).size.width * 0.35,
        //     child: MovieItem(movie: null,)),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: ColorResources.white),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    typeMovie,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorResources.white),
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: ColorResources.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorResources.yellow,
                      size: 30,
                    ),
                    Text(
                      rate,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: ColorResources.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
