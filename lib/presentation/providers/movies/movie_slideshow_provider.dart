import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_providers.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0, 6);
});