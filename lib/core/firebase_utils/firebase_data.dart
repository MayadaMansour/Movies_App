import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String downloadUrl = await storage.ref(imagePath).getDownloadURL();
  return downloadUrl;
}

// Future<void> addUpComingMovieToWatchlist(ResultsUpComing movie) async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   await firestore.collection('watchlist').add(movie.toJson());
// }

Future<void> addUpComingMovieToWatchlist(ResultsUpComing movie) async {
  CollectionReference watchlistRef = FirebaseFirestore.instance.collection('watchlist');

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



// Future<void> removeMovieFromWatchlist(String movieId) async {
//   CollectionReference watchlistRef =
//       FirebaseFirestore.instance.collection('watchlist');
//
//   await watchlistRef.doc(movieId).delete();
// }
Stream<List<ResultsUpComing>> getUpComingWatchlist() {
  CollectionReference watchlistRef = FirebaseFirestore.instance.collection('watchlist');

  return watchlistRef.snapshots().map((snapshot) {
    if (snapshot.docs.isEmpty) {
      return []; // Return an empty list if no documents
    }

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?; // Safely cast the data
      print('Document data: $data'); // Debugging
      if (data != null) {
        try {
          return ResultsUpComing.fromJson(data);
        } catch (e) {
          print('Error parsing document data: $e');
          return null; // Handle parse error
        }
      } else {
        print('Document data is null'); // Debugging
        return null; // Handle null data
      }
    }).whereType<ResultsUpComing>().toList(); // Filter out null values
  });
}
