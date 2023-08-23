import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class LocalStorageRepositoryBase {
  Future<void> toggleFavorite ( Movie movie );

  Future<bool> isMovieFavorite ( String movieId );

  Future<List<Movie>> getFavoriteMovies ({int limit = 10, offset = 0});
}