import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moves_app_project/core/model/movies_home_model/popular_movie_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/top_rated_movies_model.dart';
import 'package:moves_app_project/core/model/movies_home_model/up_coming_movie_model.dart';

import 'constants.dart';

class ApiManager {
  static Future<PopularMovieModel> getPopularMovie() async {
    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.popularMovie,
        {'api_key': ApiConstants.apiKey, 'language': 'en-US', 'page': "1"});
    var response = await http.get(url);
    return PopularMovieModel.fromJson(jsonDecode(response.body));
  }

  static Future<UpComingMoviesModel> getUpComingMovie() async {
    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.upComingMovie,
        {'api_key': ApiConstants.apiKey, 'language': 'en-US', 'page': "1"});
    var response = await http.get(url);
    return UpComingMoviesModel.fromJson(jsonDecode(response.body));
  }

  Future<TopRatedMoviesModel> getTopRateMovie() async {
    try {
      var url = Uri.https(ApiConstants.baseUrl, ApiConstants.topRated,
          {'api_key': ApiConstants.apiKey, 'language': 'en-US', 'page': "1"});
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
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
