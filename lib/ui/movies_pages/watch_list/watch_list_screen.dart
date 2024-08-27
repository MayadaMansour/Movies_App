import 'package:flutter/material.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
          child: Center(
              child: Icon(
            Icons.featured_play_list,
            color: Colors.white,
            size: 60,
          )),

    );
  }
}
