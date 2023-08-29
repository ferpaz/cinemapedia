import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/config/infrastructure/mappers/genre_mapper.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb_models.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/config/domain/datasources/movie_datasource_base.dart';
import 'package:cinemapedia/config/domain/entities/genre.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/infrastructure/mappers/movie_mapper.dart';

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
  Future<List<Movie>> search({required String query}) async
    => query.trim().isEmpty ? [] : await _getMoviesImpl(1, '/search/movie', query: query);

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


  Future<List<Movie>> _getMoviesImpl(int page, String url, { String? query }) async {
    var queryParameters = <String, dynamic>{
        'page': page,
      };

    if (query != null) queryParameters['query'] = query;

    final response = await dio.get(url, queryParameters: queryParameters);

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

  @override
  Future<List<Genre>> getGenres() async {
    final response = await dio.get('/genre/movie/list');

    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return GenresDbResponse.fromJson(response.data).genres
        .map((g) => GenreMapper.genreFromMovieDbToEntity(g))
        .toList();
    }

    throw Exception('Can\'t get genres');
  }

  @override
  Future<List<Movie>> getMoviesByGenre(int genreId, { int page = 1 }) async {
    var queryParameters = <String, dynamic>{
        'page': page,
        'with_genres': genreId,
        'release_date.lte': HumanFormats.formatDateYMD(DateTime.now())
      };

    final response = await dio.get('/discover/movie', queryParameters: queryParameters);

    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return MovieDbResponse.fromJson(response.data).results
        .where((m) => m.posterPath != '')    // esto no sirve porque siempre regresa algo pero para demostrar las lambdas
        .map((m) => MovieMapper.movieFromMovieDbToEntity(m))
        .toList();
    }

    return [];
  }
}