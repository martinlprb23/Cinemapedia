import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/data/mappers/actor_mapper.dart';
import 'package:cinemapedia/data/models/moviedb/credits_response.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDataSource {
  final dio = Dio(BaseOptions(baseUrl: Environment.BASE_URL, queryParameters: {
    'api_key': Environment.MOVIEDB_KEY,
    'language': 'es-MX'
  }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);
    List<Actor> actors =
        castResponse.cast.map((cast) => ActorMaper.castToEntity(cast)).toList();
    return actors;
  }
}
