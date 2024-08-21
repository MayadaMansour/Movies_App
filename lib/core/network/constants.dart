class ApiConstants {
  static const String baseUrl = "api.themoviedb.org";
  static const String apiKey = "70b7c391b11bbc6113f65a8c3c1c415b";
  static const String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MGI3YzM5MWIxMWJiYzYxMTNmNjVhOGMzYzFjNDE1YiIsInN1YiI6IjY0NmNjNzZkZDE4NTcyMDEwMTlhMWM0MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.HejHH1XAnBP20gxcRaNvQhbGe72BbkrIIB_7_L44JA4";
  static const String popularMovie = "/3/movie/popular";
  static const String upComingMovie = "/3/movie/upcoming";
  static const String topRated = "/3/movie/top_rated";
  static const String similarMovie = "/3/movie/movie_id/similar";
  static const String detailsMovie = "/3/movie/movie_id";
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) => '$baseImageUrl$path';
}
