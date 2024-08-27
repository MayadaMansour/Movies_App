import 'package:flutter/material.dart';

import '../../../../core/firebase_utils/firebase_data.dart';
import '../../../../core/model/movies_home_model/up_coming_movie_model.dart';
import '../../../utils/color_resource/color_resources.dart';
import '../watch_list_widget/item_watch_list.dart';
import '../watch_list_widget/watch_list_model.dart';

class WatchlistScreen extends StatelessWidget {
  WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Watch List',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ColorResources.white,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<List<ResultsUpComing>>(
        stream: getUpComingWatchlist(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies in watchlist.'));
          }

          final movieList = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) =>
                ItemWatchList(model: movieList[index]),
            separatorBuilder: (context, index) =>
                Divider(color: ColorResources.grey),
            itemCount: movieList.length,
          );
        },
      ),
    );
  }
}
