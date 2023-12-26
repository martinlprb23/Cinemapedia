import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String MOVIEDB_KEY = dotenv.env['THE_MOVIEDB_KEY'] ?? 'NO API KEY';
  static String BASE_URL = "https://api.themoviedb.org/3/";
}
