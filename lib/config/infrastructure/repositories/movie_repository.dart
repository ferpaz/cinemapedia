import 'package:cinemapedia/config/domain/datasources/movie_datasource_base.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/repositories/movie_repository_base.dart';

class MovieRepository extends  MovieRepositoryBase {

  final MovieDatasourceBase movieDataSource;

  MovieRepository(this.movieDataSource);

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1})
    => movieDataSource.getNowPlayingMovies(page: page);
}