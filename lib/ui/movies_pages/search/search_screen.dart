import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: 60,
          )),
    );
  }
}
