import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/domain/entities/movie.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlayingMovies;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({ int page });

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
  }
}