import 'package:cinemapedia/data/datasources/isar_datasource.dart';
import 'package:cinemapedia/data/repositories/local_storage_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepoProvider =
    Provider((ref) => LocalStorageRepositoryImpl(datasource: IsarDatasource()));

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepo = ref.watch(localStorageRepoProvider);
  return localStorageRepo.isMovieFavorite(movieId);
});
