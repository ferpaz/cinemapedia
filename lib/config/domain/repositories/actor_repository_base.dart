import 'package:cinemapedia/config/domain/entities/actor.dart';

abstract class ActorRepositoryBase {

  Future<List<Actor>> getActorsByMovieId(String movieId);

}