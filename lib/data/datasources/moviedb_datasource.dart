import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:dio/dio.dart';

class MovieDBDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.BASE_URL, queryParameters: {
    'api_key': Environment.MOVIEDB_KEY,
    'language': 'es-MX'
  }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('movie/now_playing');
    final List<Movie> movies = [];

    return movies;
  }
}
