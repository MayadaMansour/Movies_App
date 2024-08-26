import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moves_app_project/ui/movies_pages/search/api/search_api_constants.dart';
import 'SearchResponse.dart';

class SearchApiManager {
  static Future<SearchResponse?> searchMovies(String query,
      {int page = 1}) async {
    final apiKey = SearchApiConstants.apiKey;
    final url = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&page=$page',
    );
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final searchResponse = SearchResponse.fromJson(data);

        for (var movie in searchResponse.results!) {
          final castUrl = Uri.parse(
            'https://api.themoviedb.org/3/movie/${movie.id}/credits?api_key=$apiKey',
          );
          final castResponse = await http.get(castUrl);

          if (castResponse.statusCode == 200) {
            final castData = jsonDecode(castResponse.body);
            final castList = castData['cast'];

            // Get the top 4 cast members
            movie.cast = castList != null
                ? (castList as List)
                    .take(2)
                    .map((c) => c['name'] as String)
                    .toList()
                : [];
          }
        }
        return searchResponse;
      } else {
        // Log the error and show a message to the user
        print('Error: ${response.statusCode} ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      // Log the exception and show a message to the user
      print('Exception: $e');
      return null;
    }
  }
}
