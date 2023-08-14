import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class MovieRepositoryBase {

  Future<List<Movie>> getNowPlayingMovies({ int page = 1 });

  Future<List<Movie>> getPopularMovies({ int page = 1 });

  Future<List<Movie>> getTopRatedMovies ({ int page = 1 });

  Future<List<Movie>> getUpcomingMovies({ int page = 1 });

}