class MovieModel {
  final String image;
  final String movieTitle;
  final String movieSubtitle;
  final int releaseYear;

  MovieModel({
    required this.image,
    required this.movieTitle,
    required this.movieSubtitle,
    required this.releaseYear,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      image: json['image'] as String,
      movieTitle: json['movieTitle'] as String,
      movieSubtitle: json['movieSubtitle'] as String,
      releaseYear: json['releaseYear'] as int,
    );
  }

  // Convert a MovieModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'movieTitle': movieTitle,
      'movieSubtitle': movieSubtitle,
      'releaseYear': releaseYear,
    };
  }
}
