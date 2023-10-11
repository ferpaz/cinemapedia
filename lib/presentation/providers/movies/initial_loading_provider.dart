import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemafan/presentation/providers/providers.dart';

final initialHomeScreenLoadingProvider = Provider<bool>((ref) {
  return ref.watch(moviesSlideShowProvider).isEmpty
    || ref.watch(nowPlayingMoviesProvider).isEmpty
    || ref.watch(popularMoviesProvider).isEmpty
    || ref.watch(upcomingMoviesProvider).isEmpty
    || ref.watch(topRatedMoviesProvider).isEmpty;
});

final initialMovieScreenLoadingProvider = Provider<bool>((ref) {
  return ref.watch(movieDetailsProvider).isEmpty
    || ref.watch(actorProvider).isEmpty;
});
