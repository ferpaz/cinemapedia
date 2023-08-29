import 'package:cinemapedia/config/domain/datasources/movie_datasource_base.dart';
import 'package:cinemapedia/config/domain/entities/genre.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/repositories/movie_repository_base.dart';

class MovieRepository extends MovieRepositoryBase {
  final MovieDatasourceBase movieDataSource;

  MovieRepository(this.movieDataSource);

  @override
  Future<List<Movie>> search({required String query}) => movieDataSource.search(query: query);

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) => movieDataSource.getNowPlayingMovies(page: page);

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) => movieDataSource.getPopularMovies(page: page);

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) => movieDataSource.getTopRatedMovies(page: page);

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) => movieDataSource.getUpcomingMovies(page: page);

  @override
  Future<Movie> getMovieDetailsById(String movieId) => movieDataSource.getMovieDetailsById(movieId);

  @override
  Future<List<Genre>> getGenres() => movieDataSource.getGenres();

  @override
  Future<List<Movie>> getMoviesByGenre(int genreId, { int page = 1 }) => movieDataSource.getMoviesByGenre(genreId, page: page);

}
