import 'package:cinemafan/config/domain/entities/genre.dart';
import 'package:cinemafan/config/infrastructure/models/moviedb_models.dart';

class GenreMapper {
  static Genre genreFromMovieDbToEntity(GenreFromMovieDb genreFromMovieDb) => Genre(
    id: genreFromMovieDb.id,
    name: genreFromMovieDb.name,
  );

}