import 'package:cinemapedia/config/domain/entities/actor.dart';

abstract class ActorDatasourceBase {

  Future<List<Actor>> getActorsByMovieId(String movieId);

}