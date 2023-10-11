import 'package:cinemafan/config/domain/entities/actor.dart';

abstract class ActorRepositoryBase {

  Future<List<Actor>> getActorsByMovieId(String movieId);

}