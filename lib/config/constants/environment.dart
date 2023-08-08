import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static const String _theMovieDbApiKeyName = 'THE_MOVIEDB_KEY';

  static String theMovieDbApiKey = dotenv.env[_theMovieDbApiKeyName] ?? 'No api key found';
}