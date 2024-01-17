import 'package:cinemapedia/data/repositories/local_storage_impl.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_storage_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocalStorageDatasource>()])
// Run: dart run build_runner build
void main() {
  group('Local storage impl ...', () {
    late LocalStorageDatasource datasource;
    late LocalStorageRepositoryImpl impl;

    final movieTest = Movie(
        adult: false,
        backdropPath: "backdropPath",
        genreIds: ["123", "434"],
        id: 2310,
        originalLanguage: "es",
        originalTitle: "Movie Test",
        overview: "This is a test",
        popularity: 7.3,
        posterPath: "/poster.png",
        releaseDate: DateTime.now(),
        title: "Movie title",
        video: false,
        voteAverage: 7.5,
        voteCount: 8);

    setUp(() {
      datasource = MockLocalStorageDatasource();
      impl = LocalStorageRepositoryImpl(datasource: datasource);
    });

    test('isMovieInFavorite', () async {
      const movieId = 2310;
      when(datasource.isMovieFavorite(movieId))
          .thenAnswer((realInvocation) => Future.value(true));

      final favorite = await impl.isMovieFavorite(movieId);
      expect(favorite, isA<bool>());
      expect(favorite, equals(true));
    });

    test('loadMovies', () async {
      when(datasource.loadMovies(limit: 1))
          .thenAnswer((realInvocation) => Future.value([movieTest]));

      final loadMovies = await impl.loadMovies(limit: 1);

      expect(loadMovies, isNotNull);
      expect(loadMovies, isNotEmpty);
      expect(loadMovies.length, equals(1));
      expect(loadMovies, isA<List<Movie>>());
      expect(loadMovies[0].id, equals(2310));
    });
  });
}
