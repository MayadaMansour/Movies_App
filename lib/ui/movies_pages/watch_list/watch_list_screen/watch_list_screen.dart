import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';
import 'package:moves_app_project/ui/movies_pages/watch_list/watch_list_widget/item_watch_list.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';
import '../../../../core/firebase_utils/firebase_data.dart';

class WatchlistScreen extends StatelessWidget {
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
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              bool? confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear Watchlist'),
                  content: const Text(
                      'Are you sure you want to clear all movies from the watchlist?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await clearWatchlist();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Watchlist cleared')),
                );
              }
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          StreamBuilder<List<ResultsUpComing>>(
            stream: getUpComingWatchlist(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              }

              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: Text('')),
                );
              }

              List<ResultsUpComing> upComingMovies = snapshot.data!;

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ItemWatchList(
                      // model: upComingMovies[index],
                      onRemove: () {
                        removeMovieFromWatchlist(
                                upComingMovies[index].id.toString())
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    '${upComingMovies[index].title} removed from watchlist')),
                          );
                        });
                      },
                      date: upComingMovies[index].releaseDate ?? "",
                      img:
                          'https://image.tmdb.org/t/p/original/${upComingMovies[index].backdropPath}',
                      desc: upComingMovies[index].overview ?? "",
                      tile: upComingMovies[index].title ?? "",
                    );
                  },
                  childCount: upComingMovies.length,
                ),
              );
            },
          ),
          // Popular Movies Section
          StreamBuilder<List<ResultsPopularMovies>>(
            stream: getPopularWatchlist(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              }

              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: Text('')),
                );
              }

              List<ResultsPopularMovies> popularMovies = snapshot.data!;

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ItemWatchList(
                      // model: popularMovies[index],
                      onRemove: () {
                        removeMovieFromWatchlist(
                                popularMovies[index].id.toString())
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    '${popularMovies[index].title} removed from watchlist')),
                          );
                        });
                      },
                      date: popularMovies[index].releaseDate ?? "",
                      img:
                          'https://image.tmdb.org/t/p/original/${popularMovies[index].backdropPath}',
                      desc: popularMovies[index].overview ?? "",
                      tile: popularMovies[index].title ?? "",
                    );
                  },
                  childCount: popularMovies.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
