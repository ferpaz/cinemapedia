import 'package:cinemapedia/config/infrastructure/models/moviedb_models.dart';

class GenresDbResponse {
  GenresDbResponse({
    required this.genres,
  });

  final List<GenreFromMovieDb> genres;

  factory GenresDbResponse.fromJson(Map<String, dynamic> json) => GenresDbResponse(
    genres: List<GenreFromMovieDb>.from(json["genres"].map((x) => GenreFromMovieDb.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
  };
}