import 'package:cinemapedia/data/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/data/repositories/actor_repostiory_impl.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

//Immutable
final actorRepositoryProvider = Provider((ref) {
  return ActorRepoImpl(datasource: ActorMovieDbDatasource());
});
