import 'package:flutter/material.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Icon(
            Icons.home,
            color: Colors.white,
            size: 60,
          )),
    );;
  }
}
