import 'package:flutter/material.dart';

import '../../../utils/color_resource/color_resources.dart';

class RecommendedItem extends StatefulWidget {
  const RecommendedItem({
    required this.img,
    required this.rate,
    required this.titleMovie,
    required this.date,
    super.key,
  });

  final String img;
  final double? rate; // Nullable double
  final String titleMovie;
  final String date;

  @override
  State<RecommendedItem> createState() => _RecommendedItemState();
}

bool isSelected = false;

class _RecommendedItemState extends State<RecommendedItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Card(
        color: ColorResources.bgItem,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.img),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: -7,
                  left: -12,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = !isSelected;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: isSelected
                              ? ColorResources.yellow.withOpacity(0.6)
                              : ColorResources.grey.withOpacity(0.6),
                          size: 55,
                        ),
                        Icon(
                          isSelected ? Icons.check : Icons.add,
                          color: ColorResources.white,
                          size: 20,
                        ),
                      ],
                    ),
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
                        (widget.rate ?? 0.0).toString(), // Handle nullable rate
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorResources.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.titleMovie.isNotEmpty
                        ? widget.titleMovie
                        : "No Title", // Ensure non-empty title
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorResources.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.date.isNotEmpty ? widget.date : "No Release Date",
                    // Ensure non-empty date
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorResources.white, fontSize: 15),
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
