import 'package:cinemapedia/config/domain/entities/genre.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb_models.dart';

class GenreMapper {
  static Genre genreFromMovieDbToEntity(GenreFromMovieDb genreFromMovieDb) => Genre(
    id: genreFromMovieDb.id,
    name: genreFromMovieDb.name,
  );

}