import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moves_app_project/ui/movies_pages/search/widgets/movie_list_item.dart';
import 'package:moves_app_project/ui/movies_pages/search/widgets/no_movies_found.dart';
import 'package:moves_app_project/ui/movies_pages/search/widgets/textfield_search.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import 'api/SearchResponse.dart';
import 'api/search_api_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<SearchResults> movies = [];
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;
  String query = '';

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: height * .07,
              bottom: height * .03,
              left: width * .04,
              right: width * .04),
          child:TextFieldSearch(
            controller: searchController,
            onSubmitted: onSearch,
            onClear: onClear,
          ),
        ),
        Expanded(
          child: isLoading // Check if loading
              ? Center(child: CircularProgressIndicator(color:ColorResources.yellow,)) // Show loading indicator
              : query.isEmpty
              ? Center(child: Icon(Icons.search,size: 70,color: ColorResources.white,)) // Message when no query is entered
              : movies.isEmpty
              ? NoMoviesFound()
              : NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading &&
                  hasMore &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                fetchMovies();
              }
              return false;
            },
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: movies.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == movies.length) {
                    return Center(
                        child: CircularProgressIndicator(
                          color: ColorResources.yellow,
                        ));
                  }

                  final movie = movies[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: MovieListItem(movie: movie),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
  Future<void> fetchMovies({bool resetPage = false}) async {
    if (resetPage) {
      page = 1;
      movies.clear();
      hasMore = true;
    }

    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    final response = await SearchApiManager.searchMovies(query, page: page);

    setState(() {
      isLoading = false;
      if (response != null) {
        movies.addAll(response.results!);
        page++;
        hasMore = page <= (response.totalPages ?? 0);
      } else {
        hasMore = false;
      }
    });
  }

  void onSearch() {
    query = searchController.text;
    fetchMovies(resetPage: true);
  }
  void onClear() {
    setState(() {
      searchController.clear();
      movies.clear();
      query = '';
      hasMore = false;
    });
  }
}
