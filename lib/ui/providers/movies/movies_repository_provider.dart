import 'package:cinemapedia/data/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/data/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Immutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepoImpl(MovieDBDatasource());
});
