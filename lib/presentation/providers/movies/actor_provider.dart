import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/movies/actor_repository_provider.dart';

final actorProvider = StateNotifierProvider<ActorNotifier, Map<String, List<Actor>>>((ref) {
  final fetchActorDetails = ref.watch( actorRepositoryProvider ).getActorsByMovieId;
  return ActorNotifier(getActorDetails: fetchActorDetails);
});

typedef GetActorCallback = Future<List<Actor>> Function(String actorId);

class ActorNotifier extends StateNotifier<Map<String, List<Actor>>> {
  late List<Actor> actors;
  GetActorCallback getActorDetails;

  ActorNotifier({
    required this.getActorDetails,
  }) : super({});

  Future<void> loadActor(String movieId) async {
    if (state[movieId] != null) return;

    final actors = await getActorDetails(movieId);
    state = { ...state, movieId: actors };
  }
}