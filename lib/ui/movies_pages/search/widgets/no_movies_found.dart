import 'package:flutter/material.dart';

class NoMoviesFound extends StatelessWidget {
  const NoMoviesFound({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_movie.png'),
          SizedBox(
            height: height * .015,
          ),
          Text(
            'No movies found',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
