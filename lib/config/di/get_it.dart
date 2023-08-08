import 'package:get_it/get_it.dart';

import 'package:cinemapedia/config/domain/datasources/movie_datasource_base.dart';
import 'package:cinemapedia/config/domain/repositories/movie_repository_base.dart';
import 'package:cinemapedia/config/infrastructure/datasources/the_moviedb_datasource.dart';
import 'package:cinemapedia/config/infrastructure/repositories/movie_repository.dart';

final getIt = GetIt.instance;

void registerDependencies(){
    // Inicialize DI
  getIt.registerSingleton<MovieDatasourceBase>(TheMovieDbDataSources());
  getIt.registerSingleton<MovieRepositoryBase>(MovieRepository(getIt.get<MovieDatasourceBase>()));
}
