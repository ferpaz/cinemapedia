import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/di/get_it.dart';
import 'package:cinemapedia/config/domain/repositories/movie_repository_base.dart';

final movieRepositoryProvider = Provider<MovieRepositoryBase>((ref) => getIt.get<MovieRepositoryBase>());
