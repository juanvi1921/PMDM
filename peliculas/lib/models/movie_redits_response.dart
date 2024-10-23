import 'dart:convert';

import 'package:peliculas/models/movie.dart'; // Asegúrate de tener este modelo Movie definido

class MovieCreditsResponse {
  List<Movie> cast;

  MovieCreditsResponse({
    required this.cast,
  });

  factory MovieCreditsResponse.fromJson(String str) =>
      MovieCreditsResponse.fromMap(json.decode(str));

  factory MovieCreditsResponse.fromMap(Map<String, dynamic> json) =>
      MovieCreditsResponse(
        cast: List<Movie>.from(json["cast"].map((x) => Movie.fromMap(x))), // Mapea cada película
      );
}
