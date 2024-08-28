import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';
import 'package:moves_app_project/ui/movies_pages/watch_list/watch_list_widget/item_watch_list.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';
import '../../../../core/firebase_utils/firebase_data.dart';

class WatchlistScreen extends StatelessWidget {
  // Function to clear all movies from the watchlist
  Future<void> clearWatchlist() async {
    CollectionReference watchlistRef =
        FirebaseFirestore.instance.collection('watchlist');
    QuerySnapshot querySnapshot = await watchlistRef.get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Watchlist',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ColorResources.white,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorResources.bgColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              // Confirm clear action
              bool? confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Clear Watchlist'),
                  content: Text(
                      'Are you sure you want to clear all movies from the watchlist?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Clear'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await clearWatchlist();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Watchlist cleared')),
                );
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<List<ResultsUpComing>>(
        stream: getUpComingWatchlist(), // Listens to real-time updates
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies in watchlist'));
          }

          List<ResultsUpComing> movies = snapshot.data!;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return ItemWatchList(
                model: movies[index],
                onRemove: () {
                  removeMovieFromWatchlist(movies[index].id.toString())
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              '${movies[index].title} removed from watchlist')),
                    );
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
