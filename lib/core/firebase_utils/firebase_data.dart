import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';

Future<String> uploadImage(File imageFile) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref =
      storage.ref().child('movie_images/${imageFile.path.split('/').last}');
  UploadTask uploadTask = ref.putFile(imageFile);
  TaskSnapshot taskSnapshot = await uploadTask;
  return await taskSnapshot.ref.getDownloadURL();
}

Future<String> getImageUrl(String imagePath) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  return await storage.ref(imagePath).getDownloadURL();
}

Future<void> addUpComingMovieToWatchlist(ResultsUpComing movie) async {
  CollectionReference watchlistRef =
      FirebaseFirestore.instance.collection('watchlist');
  try {
    await watchlistRef.doc(movie.id.toString()).set(movie.toJson());
    print('Movie added to watchlist successfully');
  } catch (e) {
    print('Failed to add movie to watchlist: $e');
  }
}

Future<void> addUPopularMovieToWatchlist(ResultsPopularMovies movie) async {
  if (movie.id == null) {
    print('Movie ID is null');
    return;
  }

  CollectionReference watchlistRef =
      FirebaseFirestore.instance.collection('watchlist');
  try {
    await watchlistRef.doc(movie.id.toString()).set(movie.toJson());
    print('Movie added to watchlist successfully');
  } catch (e) {
    print('Failed to add movie to watchlist: $e');
  }
}

Future<void> removeMovieFromWatchlist(String movieId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    await firestore.collection('watchlist').doc(movieId).delete();
    print('Movie removed from watchlist successfully');
  } catch (e) {
    print('Failed to remove movie from watchlist: $e');
  }
}

Stream<List<ResultsUpComing>> getUpComingWatchlist() {
  CollectionReference watchlistRef =
      FirebaseFirestore.instance.collection('watchlist');

  return watchlistRef.snapshots().map((snapshot) {
    if (snapshot.docs.isEmpty) {
      return [];
    }

    return snapshot.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>?;
          print('Document data: $data');
          if (data != null) {
            try {
              return ResultsUpComing.fromJson(data);
            } catch (e) {
              print('Error parsing document data: $e');
              return null;
            }
          } else {
            print('Document data is null');
            return null;
          }
        })
        .whereType<ResultsUpComing>()
        .toList();
  });
}

Stream<List<ResultsPopularMovies>> getPopularWatchlist() {
  CollectionReference watchlistRef =
      FirebaseFirestore.instance.collection('watchlist');

  return watchlistRef.snapshots().map((snapshot) {
    if (snapshot.docs.isEmpty) {
      return [];
    }

    return snapshot.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>?;
          print('Document data: $data');
          if (data != null) {
            try {
              return ResultsPopularMovies.fromJson(data);
            } catch (e) {
              print('Error parsing document data: $e');
              return null;
            }
          } else {
            print('Document data is null');
            return null;
          }
        })
        .whereType<ResultsPopularMovies>()
        .toList();
  });
}
