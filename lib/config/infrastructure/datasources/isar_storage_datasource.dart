import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cinemapedia/config/domain/datasources/local_storage_datasource_base.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';

class IsarStorageDatasource extends LocalStorageDatasourceBase {
  late Future<Isar> database;

  Future<Isar> _openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], directory: dir.path, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  IsarStorageDatasource() {
    database = _openDatabase();
  }

  @override
  Future<bool> isMovieFavorite(String movieId) async {
    final db = await database;

    final movie = await db.movies
      .filter()
      .idEqualTo(movieId)
      .findFirst();

    return movie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final db = await database;

    final m = await db.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();

    if (m == null) {
      await db.writeTxn(() async => db.movies.put(movie));
    } else {
      await db.writeTxn(() async => db.movies.delete(movie.pk!));
    }
  }

  @override
  Future<List<Movie>> getFavoriteMovies({int limit = 10, offset = 0}) async {
    final db = await database;

    return db.movies.where()
      .offset(offset)
      .limit(limit)
      .findAll();
  }
}