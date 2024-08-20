import 'package:flutter/material.dart';

import '../../utils/color_resource/color_resources.dart';
import 'browse_category_item.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.bgColor,
      appBar: AppBar(
        title: Text(
          "Browse Category",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 27,
              ),
        ),
        backgroundColor: ColorResources.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: 100, // Number of rows
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BrowseCategoryItem(title: 'Action'),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * .04),
                  Expanded(
                    child: BrowseCategoryItem(title: 'Action'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}