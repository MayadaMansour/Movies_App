import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

class RecomendedScreenSection extends StatelessWidget {
  RecomendedScreenSection(
      {super.key,
      required this.title,
      required this.time,
      required this.rate,
      required this.movieName});

  final String title;
  final String rate;
  final String time;
  final String movieName;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Card(
                      color: ColorResources.bgItem,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                              ),
                              Positioned(
                                top: -7,
                                left: -12,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color:
                                          ColorResources.grey.withOpacity(0.6),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: ColorResources.yellow,
                                    ),
                                    Text(
                                      rate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: ColorResources.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  movieName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: ColorResources.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  time,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: ColorResources.white,
                                          fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 15);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
