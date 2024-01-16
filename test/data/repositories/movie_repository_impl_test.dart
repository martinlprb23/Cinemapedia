import 'package:cinemapedia/data/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MoviesDatasource>()])
// Run: dart run build_runner build

void main() {
  final movieTest = Movie(
      adult: false,
      backdropPath: "backdropPath",
      genreIds: ["123", "456"],
      id: 123,
      originalLanguage: "en",
      originalTitle: "Title",
      overview: "This is a test movie",
      popularity: 7.5,
      posterPath: "/poster.png",
      releaseDate: DateTime.now(),
      title: "Test Movie",
      video: false,
      voteAverage: 8.0,
      voteCount: 120);

  group('Movie repository impl', () {
    late MoviesDatasource moviesDatasource;
    late MovieRepoImpl movieRepoImpl;

    setUp(() {
      moviesDatasource = MockMoviesDatasource();
      movieRepoImpl = MovieRepoImpl(moviesDatasource);
    });

    test('getNowPlaying', () async {
      when(moviesDatasource.getNowPlaying())
          .thenAnswer((realInvocation) => Future.value([movieTest]));

      final nowPlayingResponse = await movieRepoImpl.getNowPlaying();

      expect(nowPlayingResponse, isNotNull);
      expect(nowPlayingResponse, isA<List<Movie>>());
      expect(nowPlayingResponse.length, equals(1));
    });

    test('getMovieById', () async {
      when(moviesDatasource.getMovieById("123"))
          .thenAnswer((realInvocation) => Future.value(movieTest));

      final movieResponse = await movieRepoImpl.getMovieById("123");

      expect(movieResponse, isNotNull);
      expect(movieResponse, isA<Movie>());
      expect(movieResponse.title, equals("Test Movie"));
    });
  });
}
