import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class MovieRepositoryBase {

  Future<List<Movie>> getNowPlayingMovies({ int page = 1 });

}