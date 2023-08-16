import 'package:cinemapedia/config/infrastructure/models/themoviedb/movie_details_moviedb.dart';
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
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async
    => await _getMoviesImpl(page, '/movie/now_playing');

  @override
  Future<List<Movie>> getPopularMovies({int page = 1})
    => _getMoviesImpl(page, '/movie/popular');

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1})
    => _getMoviesImpl(page, '/movie/top_rated');

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1})
    => _getMoviesImpl(page, '/movie/upcoming');


  Future<List<Movie>> _getMoviesImpl(int page, String url) async {
    final response = await dio.get(
      url,
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

  @override
  Future<Movie> getMovieDetailsById(String movieId) async {
    final response = await dio.get('/movie/$movieId');

    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return MovieMapper.movieDetailsFromMovieDbToEntity(MovieDetailsFromMovieDb.fromJson(response.data));
    }

    throw Exception('Movie with id: $movieId not found');
  }
}