import 'package:cinemapedia/config/domain/datasources/local_storage_datasource_base.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/repositories/local_storage_repository_base.dart';

class IsarStorageRepository extends LocalStorageRepositoryBase {
  final LocalStorageDatasourceBase localStorageDatasource;

  IsarStorageRepository(this.localStorageDatasource);

  @override
  Future<List<Movie>> getFavoriteMovies({int limit = 10, offset = 0}) => localStorageDatasource.getFavoriteMovies(limit: limit, offset: offset);

  @override
  Future<bool> isMovieFavorite(String movieId) => localStorageDatasource.isMovieFavorite(movieId);

  @override
  Future<void> toggleFavorite(Movie movie) => localStorageDatasource.toggleFavorite(movie);
}