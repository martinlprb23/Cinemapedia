import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/data/mappers/mappers.dart';
import 'package:cinemapedia/data/models/models.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/entities.dart';

import 'package:dio/dio.dart';

class MovieDBDatasource extends MoviesDatasource {
  var dio = Dio(BaseOptions(baseUrl: Environment.BASE_URL, queryParameters: {
    'api_key': Environment.MOVIEDB_KEY,
    'language': 'es-MX'
  }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDBResponse.results
        .where((element) => element.posterPath != 'no-poster')
        .map((movie) => MovieMapper.movieDBToEntity(movie))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('movie/$id');
    if (response.statusCode != 200) throw Exception('Movie not found');
    final movieDB = MovieDetails.fromJson(response.data);
    final movie = MovieMapper.movieDetailsToEntity(movieDB);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response =
        await dio.get('search/movie', queryParameters: {'query': query});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final response = await dio.get('movie/$movieId/similar');
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('movie/$movieId/videos');
    final movieDbVideosResponse = MoviedbVideosResponse.fromJson(response.data);
    final videos = <Video>[];

    for (final video in movieDbVideosResponse.results) {
      if (video.site == 'YouTube') {
        final movieVideo = VideoMapper.moviedbVideoToEntity(video);
        videos.add(movieVideo);
      }
    }

    return videos;
  }
}
