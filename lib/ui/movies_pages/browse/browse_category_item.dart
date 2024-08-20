import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

class BrowseCategoryItem extends StatelessWidget {
  final String title;

  BrowseCategoryItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.width * 0.36,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorResources.grey,
                borderRadius: BorderRadius.circular(19.0),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  color: ColorResources.white,
                  size: 50,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorResources.bgColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(9.0),
              ),
              alignment: Alignment.center,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
