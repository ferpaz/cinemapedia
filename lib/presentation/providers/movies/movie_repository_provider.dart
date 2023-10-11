import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemafan/config/di/get_it.dart';
import 'package:cinemafan/config/domain/repositories/movie_repository_base.dart';

final movieRepositoryProvider = Provider<MovieRepositoryBase>((ref) => getIt.get<MovieRepositoryBase>());
