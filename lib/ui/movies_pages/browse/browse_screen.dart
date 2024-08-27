import 'package:flutter/material.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
          child: Icon(
            Icons.movie,
            color: Colors.white,
            size: 60,
          )),
    );
  }
}
