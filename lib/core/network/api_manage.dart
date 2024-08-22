import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';

import '../model/movies_home_model/movie_vedio.dart';
import 'constants.dart';

class ApiManager {
  Future<PopularMovieModel> getPopularMovie() async {
    try {
      var url = Uri.https(ApiConstants.baseUrl, ApiConstants.popularMovie,
          {'api_key': ApiConstants.apiKey, 'language': 'en-US', 'page': "1"});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return PopularMovieModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (error) {
      print(error);
      throw Exception('Error occurred: $error');
    }
  }

  Future<MovieTrailer> getMovieTrailer(int id) async {
    try {
      var url = Uri.https(ApiConstants.baseUrl, '/3/movie/$id/videos',
          {'api_key': ApiConstants.apiKey, 'language': 'en-US'});

      // Add Authorization header
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${ApiConstants.token}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return MovieTrailer.fromJson(jsonDecode(response.body));
      } else {
        // Print response body for debugging
        print('Error response: ${response.body}');
        throw Exception('Failed to load movie trailer');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error occurred: $error');
    }
  }

  Future<UpComingMoviesModel> getUpComingMovie() async {
    try {
      var url = Uri.https(ApiConstants.baseUrl, ApiConstants.upComingMovie,
          {'api_key': ApiConstants.apiKey, 'language': 'en-US', 'page': "1"});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return UpComingMoviesModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load upcoming movies');
      }
    } catch (error) {
      print(error);
      throw Exception('Error occurred: $error');
    }
  }

  Future<TopRatedMoviesModel> getTopRateMovie() async {
    try {
      var url = Uri.https(ApiConstants.baseUrl, ApiConstants.topRated,
          {'api_key': ApiConstants.apiKey, 'language': 'en-US', 'page': "1"});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return TopRatedMoviesModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load top-rated movies');
      }
    } catch (error) {
      print(error);
      throw Exception('Error occurred: $error');
    }
  }
}
