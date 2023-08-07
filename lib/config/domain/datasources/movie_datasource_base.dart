import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class MovieDatasourceBase {

  Future<List<Movie>> getNowPlayingMovies({ int page = 1 });

}