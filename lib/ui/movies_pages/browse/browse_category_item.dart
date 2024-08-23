import 'package:flutter/material.dart';

class BrowseCategoryItem extends StatelessWidget {
  final String title;
  final String imagePath;

  const BrowseCategoryItem({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.36,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Text overlay
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

String getImagePathForGenre(String genreName) {
  switch (genreName.toLowerCase()) {
    case 'action':
      return 'assets/images/action.png';
    case 'drama':
      return 'assets/images/drama.jpg';
    case 'comedy':
      return 'assets/images/Comedy.jpg';
    case 'romance':
      return 'assets/images/romantic.jpg';
    case 'horror':
      return 'assets/images/Horror.jpg';
    case 'crime':
      return 'assets/images/Crime.jpg';
    case 'thriller':
      return 'assets/images/Thriller.jpg';
    default:
      return 'assets/images/cinema.jpg';
  }
}
