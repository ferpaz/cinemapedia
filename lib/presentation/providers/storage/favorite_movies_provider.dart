import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemafan/config/domain/entities/movie.dart';
import 'package:cinemafan/config/domain/repositories/local_storage_repository_base.dart';
import 'package:cinemafan/presentation/providers/providers.dart';

final favoriteMoviesProvider = StateNotifierProvider<FavoriteMoviesNotifier, Map<String, Movie>>((ref) {
  final storage = ref.watch(localStorageRepositoryProvider);
  return FavoriteMoviesNotifier(localStorageRepository: storage);
});

class FavoriteMoviesNotifier extends StateNotifier<Map<String, Movie>> {
  int _page = 0;

  final LocalStorageRepositoryBase _localStorageRepository;

  FavoriteMoviesNotifier({
    required LocalStorageRepositoryBase localStorageRepository,
  }): _localStorageRepository = localStorageRepository, super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await _localStorageRepository.getFavoriteMovies(limit: 20, offset: _page * 10);
    _page++;

    final tempMovies = <String, Movie>{};

    for (final movie in movies) {
      tempMovies[movie.id] = movie;
    }

    state = { ...state, ...tempMovies };

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await _localStorageRepository.toggleFavorite(movie);

    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites){
      state.remove(movie.id);
      state = { ...state};
    } else {
      state = { ...state, movie.id: movie };
    }
  }
}
