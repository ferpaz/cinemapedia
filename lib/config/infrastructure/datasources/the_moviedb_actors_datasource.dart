import 'package:dio/dio.dart';

import 'package:cinemafan/config/constants/environment.dart';
import 'package:cinemafan/config/domain/datasources/actor_datasource_base.dart';
import 'package:cinemafan/config/domain/entities/actor.dart';
import 'package:cinemafan/config/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemafan/config/infrastructure/models/moviedb_models.dart';

class TheMovieDbActorsDatasource extends ActorDatasourceBase {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.theMovieDbBaseUrl,
      queryParameters: {
        'api_key': Environment.theMovieDbApiKey,
        'language': 'es-US',
      },
      validateStatus: (status) {
        if (status == null)
          return false;
        else if (status == 422)
          return true;
        else
          return status >= 200 && status < 300;
      },
    )
  );

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async {

    final response = await dio.get(
      '/movie/$movieId/credits',
    );

    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return CreditsResponse.fromJson(response.data).cast
        .map((m) => ActoMapper.castFromMovieDbToEntity(m))
        .toList();
    }

    return [];
  }
}