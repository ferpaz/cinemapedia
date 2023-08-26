import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/domain/entities/genre.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final genreProvider = StateNotifierProvider<GenreNotifier, List<Genre>>((ref) {
  final fetchGenres = ref.watch( movieRepositoryProvider ).getGenres;
  return GenreNotifier(getGenres: fetchGenres);
});

typedef GetGenresCallback = Future<List<Genre>> Function();

class GenreNotifier extends StateNotifier<List<Genre>> {
  late List<Genre> genres;
  GetGenresCallback getGenres;

  GenreNotifier({
    required this.getGenres,
  }) : super([]);

  Future<void> loadGenres() async {
    if (state.isNotEmpty) return;

    final genres = await getGenres();
    genres.sort((a, b) => a.name.compareTo(b.name));
    state = genres;
  }
}