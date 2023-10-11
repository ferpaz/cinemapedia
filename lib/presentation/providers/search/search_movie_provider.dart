import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemafan/config/domain/entities/movie.dart';
import 'package:cinemafan/presentation/providers/providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final seachMovies = ref.watch(movieRepositoryProvider).search;
  return SearchedMoviesNotifier(searchMovies: seachMovies, ref: ref);
});

typedef SearchedMoviesCallback = Future<List<Movie>> Function({required String query});

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchedMoviesCallback searchMovies;
  final Ref ref;

  bool isLoading = false;

  SearchedMoviesNotifier({
    required this.searchMovies,
    required this.ref
  }) : super([]);

  Future<List<Movie>> searchMoviesByQuery({ required String query }) async {
    if (isLoading) return state;

    // actualiza el valor del query
    ref.read(searchQueryProvider.notifier).update((state) => query.trim());

    final movies = await searchMovies(query: query.trim());
    state = movies;
    isLoading = false;

    return movies;
  }
}