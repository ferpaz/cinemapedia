import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static const String _theMovieDbApiKeyName = 'THE_MOVIEDB_KEY';

  // The MovieDB constants
  static const String theMovieDbBaseUrl = 'https://api.themoviedb.org/3';
  static const String theMovieDbImageBaseUrl = 'https://image.tmdb.org/t/p';

  static String theMovieDbApiKey = dotenv.env[_theMovieDbApiKeyName] ?? 'No api key found';

}