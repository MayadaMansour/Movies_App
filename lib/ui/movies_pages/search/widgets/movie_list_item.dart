import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/SearchResponse.dart';

class MovieListItem extends StatelessWidget {
  final SearchResults movie;
  const MovieListItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Column(
      children: [

        ///add inkwell to navigate to details(movie id)
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: width * .06, vertical: height * .01),
          child: Row(
            children: [
              if (movie.posterPath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl:
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    width: width * .46,
                    height: height * .26,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.yellow,
                        )
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/no_image.png',
                    width: width * .46,
                    height: height * .26,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(width: width*.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title!,
                        style:
                        const TextStyle(fontSize: 20, color: Colors.white),
                        maxLines: 3),
                    Text(
                      getFormattedYear(movie.releaseDate),
                      style: const TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 146, 145, 145)),
                    ),
                    Text(movie.cast?.join(', ') ?? 'No cast information',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 146, 145, 145)),
                        maxLines: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
         Divider(
           thickness: 1,
           color: Color.fromARGB(255, 146, 145, 145),
         ),
      ],
    );
  }
}

String getFormattedYear(String? releaseDate) {
  try {
    final formatter = DateFormat('yyyy');
    final dateTime = DateTime.parse(releaseDate!);
    return formatter.format(dateTime);
  } catch (e) {
    return '';
  }
}