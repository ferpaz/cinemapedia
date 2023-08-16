import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';

final movieDetailsProvider = StateNotifierProvider<MovieDetailsNotifier, Map<String, Movie>>((ref) {
  final fetchMovieDetails = ref.watch( movieRepositoryProvider ).getMovieDetailsById;
  return MovieDetailsNotifier(getMovieDetails: fetchMovieDetails);
});


typedef GetMovieDetailsCallback = Future<Movie> Function(String movieId);

class MovieDetailsNotifier extends StateNotifier<Map<String, Movie>> {

  late Movie movie;
  GetMovieDetailsCallback getMovieDetails;

  MovieDetailsNotifier({
    required this.getMovieDetails,
  }) : super({});

  Future<void> loadMovieDetails(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovieDetails(movieId);
    state = { ...state, movieId: movie };
  }
}