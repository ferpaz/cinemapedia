import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/config/domain/datasources/movie_datasource_base.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/config/infrastructure/models/themoviedb/the_moviedb_response.dart';

class TheMovieDbDataSources extends MovieDatasourceBase {

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
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
      });

    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return MovieDbResponse.fromJson(response.data).results
        .where((m) => m.posterPath != '')    // esto no sirve porque siempre regresa algo pero para demostrar las lambdas
        .map((m) => MovieMapper.movieFromMovieDbToEntity(m))
        .toList();
    }

    return [];
  }
}