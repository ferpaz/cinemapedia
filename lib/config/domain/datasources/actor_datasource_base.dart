import 'package:cinemafan/config/domain/entities/actor.dart';

abstract class ActorDatasourceBase {

  Future<List<Actor>> getActorsByMovieId(String movieId);

}