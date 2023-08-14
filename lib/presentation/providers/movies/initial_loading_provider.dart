import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  return ref.watch(moviesSlideShowProvider).isEmpty
    || ref.watch(nowPlayingMoviesProvider).isEmpty
    || ref.watch(popularMoviesProvider).isEmpty
    || ref.watch(upcomingMoviesProvider).isEmpty
    || ref.watch(topRatedMoviesProvider).isEmpty;
});