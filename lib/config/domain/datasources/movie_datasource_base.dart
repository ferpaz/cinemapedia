import 'package:cinemafan/config/domain/entities/genre.dart';
import 'package:cinemafan/config/domain/entities/movie.dart';

abstract class MovieDatasourceBase {

  Future<List<Movie>> search({ required String query });

  Future<List<Movie>> getNowPlayingMovies({ int page = 1 });

  Future<List<Movie>> getPopularMovies({ int page = 1 });

  Future<List<Movie>> getTopRatedMovies ({ int page = 1 });

  Future<List<Movie>> getUpcomingMovies({ int page = 1 });

  Future<Movie> getMovieDetailsById(String movieId);

  Future<List<Genre>> getGenres();

  Future<List<Movie>> getMoviesByGenre(int genreId, { int page = 1 });
}