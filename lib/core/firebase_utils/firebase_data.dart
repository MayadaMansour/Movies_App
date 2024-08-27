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

Future<void> addUpComingMovieToWatchlist(ResultsUpComing movie) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore.collection('watchlist').add(movie.toJson());
}

Stream<List<ResultsUpComing>> getUpComingWatchlist() {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return firestore.collection('watchlist').snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => ResultsUpComing.fromJson(doc.data()))
        .toList();
  });
}
