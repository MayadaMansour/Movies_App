import 'package:flutter/material.dart';
import 'dart:convert';
import '../../utils/color_resource/color_resources.dart';
import 'api/SearchResponse.dart';
import 'movie_list_item.dart';
import 'api/search_api_constants.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTextController = TextEditingController();
  List<SearchResults>? searchResults;

  @override
  void initState() {
    super.initState();
    searchTextController.addListener(onSearchTextChanged);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void onSearchTextChanged() async {
    final query = searchTextController.text;
    if (query.isEmpty) {
      setState(() {
        searchResults = null;
      });
      return;
    }

    final results = await searchMovies(query);
    setState(() {
      searchResults = results.results;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        TextField(
          cursorColor: ColorResources.yellow,
          controller: searchTextController,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 146, 145, 145)),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    searchTextController.clear();
                  });
                },
                icon: Icon(Icons.clear)),
            prefixIcon: Icon(
              Icons.search_sharp,
              color: Colors.white,
              size: 25,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: ColorResources.yellow,
                  width: 2,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(width: 1, color: Colors.white)),
          ),
        ),
        if (searchResults != null && searchResults!.isEmpty ||
            searchResults == null)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/no_movie.png'),
                SizedBox(height: height*.015,),
                Text('No movies found'),
              ],
            ),
          ),
        if (searchResults != null && searchResults!.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: searchResults!.length,
              itemBuilder: (context, index) {
                final movie = searchResults![index];
                return MovieListItem(movie: movie);
              },
            ),
          )
      ],
    );
  }
}
Future<SearchResponse> searchMovies(String query) async {
  final apiKey = SearchApiConstants.apiKey; // Replace with your actual API key
  final url = Uri.parse(
    'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query',
  );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return SearchResponse.fromJson(data);
  } else {
    throw Exception('Failed to load movies');
  }
}

