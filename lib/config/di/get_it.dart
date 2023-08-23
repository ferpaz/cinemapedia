import 'package:get_it/get_it.dart';

import 'package:cinemapedia/config/domain/datasources/actor_datasource_base.dart';
import 'package:cinemapedia/config/domain/datasources/local_storage_datasource_base.dart';
import 'package:cinemapedia/config/domain/datasources/movie_datasource_base.dart';
import 'package:cinemapedia/config/domain/repositories/actor_repository_base.dart';
import 'package:cinemapedia/config/domain/repositories/local_storage_repository_base.dart';
import 'package:cinemapedia/config/domain/repositories/movie_repository_base.dart';
import 'package:cinemapedia/config/infrastructure/datasources/isar_storage_datasource.dart';
import 'package:cinemapedia/config/infrastructure/datasources/the_moviedb_actors_datasource.dart';
import 'package:cinemapedia/config/infrastructure/datasources/the_moviedb_datasource.dart';
import 'package:cinemapedia/config/infrastructure/repositories/actors_repository.dart';
import 'package:cinemapedia/config/infrastructure/repositories/isar_storage_repository.dart';
import 'package:cinemapedia/config/infrastructure/repositories/movie_repository.dart';

final getIt = GetIt.instance;

void registerDependencies(){
    // Inicialize DI
  getIt.registerSingleton<MovieDatasourceBase>(TheMovieDbDataSources());
  getIt.registerSingleton<MovieRepositoryBase>(MovieRepository(getIt.get<MovieDatasourceBase>()));

  getIt.registerSingleton<ActorDatasourceBase>(TheMovieDbActorsDatasource());
  getIt.registerSingleton<ActorRepositoryBase>(ActorRepository(getIt.get<ActorDatasourceBase>()));

  getIt.registerSingleton<LocalStorageDatasourceBase>(IsarStorageDatasource());
  getIt.registerSingleton<LocalStorageRepositoryBase>(IsarStorageRepository(getIt.get<LocalStorageDatasourceBase>()));
}
