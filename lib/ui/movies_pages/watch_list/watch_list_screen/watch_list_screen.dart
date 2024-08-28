import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/similar_movies_model.dart';
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

  Stream<List<dynamic>> getAllWatchlistMovies() {
    CollectionReference watchlistRef =
        FirebaseFirestore.instance.collection('watchlist');

    return watchlistRef.snapshots().map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>?;
            if (data != null) {
              final type = data['type'] as String?;
              print('Document type: $type');

              try {
                if (type == 'upcoming') {
                  return ResultsUpComing.fromJson(data);
                } else if (type == 'popular') {
                  return ResultsPopularMovies.fromJson(data);
                } else if (type == 'similar') {
                  return ResultsSimilarMovie.fromJson(data);
                } else {
                  print('Unknown type: $type');
                }
              } catch (e) {
                print('Error parsing document data: $e');
              }
            } else {
              print('Document data is null');
            }

            return null;
          })
          .whereType<dynamic>()
          .toList();
    });
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
          StreamBuilder<List<dynamic>>(
            stream: getAllWatchlistMovies(),
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
                  child: Center(child: Text('No movies in watchlist')),
                );
              }

              final allMovies = snapshot.data!;
              final upComingMovies =
                  allMovies.whereType<ResultsUpComing>().toList();
              final popularMovies =
                  allMovies.whereType<ResultsPopularMovies>().toList();
              final similarMovies =
                  allMovies.whereType<ResultsSimilarMovie>().toList();

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    dynamic movie;
                    String date;
                    String img;
                    String desc;
                    String title;

                    if (index < upComingMovies.length) {
                      movie = upComingMovies[index];
                      date = movie.releaseDate ?? "";
                      img =
                          'https://image.tmdb.org/t/p/original/${movie.backdropPath}';
                      desc = movie.overview ?? "";
                      title = movie.title ?? "";
                    } else if (index <
                        upComingMovies.length + popularMovies.length) {
                      movie = popularMovies[index - upComingMovies.length];
                      date = movie.releaseDate ?? "";
                      img =
                          'https://image.tmdb.org/t/p/original/${movie.backdropPath}';
                      desc = movie.overview ?? "";
                      title = movie.title ?? "";
                    } else {
                      movie = similarMovies[
                          index - upComingMovies.length - popularMovies.length];
                      date = movie.releaseDate ?? "";
                      img =
                          'https://image.tmdb.org/t/p/original/${movie.backdropPath}';
                      desc = movie.overview ?? "";
                      title = movie.title ?? "";
                    }

                    return ItemWatchList(
                      onRemove: () {
                        removeMovieFromWatchlist(movie.id.toString()).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    '${movie.title} removed from watchlist')),
                          );
                        });
                      },
                      date: date,
                      img: img,
                      desc: desc,
                      tile: title,
                    );
                  },
                  childCount: upComingMovies.length +
                      popularMovies.length +
                      similarMovies.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
