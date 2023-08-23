import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/di/get_it.dart';
import 'package:cinemapedia/config/domain/repositories/local_storage_repository_base.dart';

final localStorageRepositoryProvider = Provider((ref) => getIt.get<LocalStorageRepositoryBase>());

final isFavoriteMovieProvider = FutureProvider.family.autoDispose((ref, String movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});
