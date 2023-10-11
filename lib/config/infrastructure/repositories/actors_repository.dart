import 'package:cinemafan/config/domain/datasources/actor_datasource_base.dart';
import 'package:cinemafan/config/domain/entities/actor.dart';
import 'package:cinemafan/config/domain/repositories/actor_repository_base.dart';

class ActorRepository extends ActorRepositoryBase {
  ActorDatasourceBase actorDataSource;

  ActorRepository(this.actorDataSource);

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) => actorDataSource.getActorsByMovieId(movieId);

}