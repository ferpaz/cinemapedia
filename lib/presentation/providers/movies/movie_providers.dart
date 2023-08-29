import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/domain/entities/movie.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlayingMovies;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getPopularMovies;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getTopRatedMovies;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getUpcomingMovies;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});


typedef MovieCallback = Future<List<Movie>> Function({ int page });

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    currentPage++;
    final movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    isLoading = false;
  }
}

final moviesByGenreProvider = StateNotifierProvider<MoviesByGenreNotifier, Map<int, List<Movie>>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getMoviesByGenre;
  return MoviesByGenreNotifier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieByGenreCallback = Future<List<Movie>> Function(int genreId, { int page });

class MoviesByGenreNotifier extends StateNotifier<Map<int, List<Movie>>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieByGenreCallback fetchMoreMovies;

  MoviesByGenreNotifier({
    required this.fetchMoreMovies,
  }) : super({});

  Future<void> loadNextPage(int genreId) async {
    if (isLoading) return;

    currentPage++;
    final movies = await fetchMoreMovies(genreId, page: currentPage);

    // add movies to the state map using genreId as key, consider if the state is null, if the state does not have any movies asociated to the genreId, and if the state has the genreId, add the movies to the existing list
    state = {
      ...state,
      genreId: [
        ...state[genreId] ?? [],
        ...movies
      ]
    };

    isLoading = false;
  }
}