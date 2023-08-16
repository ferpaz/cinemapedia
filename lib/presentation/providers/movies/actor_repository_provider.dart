import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/di/get_it.dart';
import 'package:cinemapedia/config/domain/repositories/actor_repository_base.dart';


final actorRepositoryProvider = Provider<ActorRepositoryBase>((ref) => getIt.get<ActorRepositoryBase>());
