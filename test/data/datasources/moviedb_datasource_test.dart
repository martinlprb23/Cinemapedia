import 'dart:io';

import 'package:cinemapedia/data/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('MovieDbDatasource', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());

    late Dio dio;
    late DioAdapter dioAdapter;
    late MovieDBDatasource datasource;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
      datasource = MovieDBDatasource();
      datasource.dio = dio;
    });

    final moviesResponse = {
      'page': 1,
      'dates': null,
      'total_pages': 1,
      'total_results': 3,
      'results': [
        {
          'adult': false,
          'backdrop_path': '/backdrop1.jpg',
          'genre_ids': [28, 12],
          'id': 123,
          'original_language': 'en',
          'original_title': 'Original Title 1',
          'overview': 'Movie overview 1',
          'popularity': 7.5,
          'poster_path': '/poster1.jpg',
          'release_date': '2022-01-01',
          'title': 'Movie Title 1',
          'video': false,
          'vote_average': 8.0,
          'vote_count': 100,
        },
        {
          'adult': false,
          'backdrop_path': '/backdrop2.jpg',
          'genre_ids': [35, 18],
          'id': 456,
          'original_language': 'es',
          'original_title': 'Original Title 2',
          'overview': 'Movie overview 2',
          'popularity': 8.0,
          'poster_path': '/poster2.jpg',
          'release_date': '2022-02-01',
          'title': 'Movie Title 2',
          'video': true,
          'vote_average': 9.0,
          'vote_count': 150,
        },
        {
          'adult': true,
          'backdrop_path': '/backdrop3.jpg',
          'genre_ids': [18],
          'id': 789,
          'original_language': 'fr',
          'original_title': 'Original Title 3',
          'overview': 'Movie overview 3',
          'popularity': 6.5,
          'poster_path': '/poster3.jpg',
          'release_date': '2022-03-01',
          'title': 'Movie Title 3',
          'video': false,
          'vote_average': 7.5,
          'vote_count': 80,
        },
      ],
    };

    test(
        'should return a list of movies when calling getNowPlaying, getPopular, getTopRated and getUpcoming',
        () async {
      const pathNowPlaying = 'movie/now_playing';
      const pathPopular = 'movie/popular';
      const pathTopRated = 'movie/top_rated';
      const pathUpcoming = 'movie/upcoming';

      dioAdapter.onGet(pathNowPlaying, (server) {
        return server.reply(200, moviesResponse);
      });
      dioAdapter.onGet(pathPopular, (server) {
        return server.reply(200, moviesResponse);
      });
      dioAdapter.onGet(pathTopRated, (server) {
        return server.reply(200, moviesResponse);
      });
      dioAdapter.onGet(pathUpcoming, (server) {
        return server.reply(200, moviesResponse);
      });

      //Act
      final response = await dio.get(pathNowPlaying);
      final resultNowPlaying = await datasource.getNowPlaying(page: 1);
      final resultPopular = await datasource.getPopular(page: 1);
      final resultTopRated = await datasource.getTopRated(page: 1);
      final resultUpcoming = await datasource.getUpcoming(page: 1);

      //Assert
      expect(response.statusCode, equals(200));

      // Now Playing movies
      expect(resultNowPlaying, isA<List<Movie>>());
      expect(resultNowPlaying.length, equals(3));

      expect(resultNowPlaying[0].title, equals('Movie Title 1'));
      expect(resultNowPlaying[1].title, equals('Movie Title 2'));
      expect(resultNowPlaying[2].title, equals('Movie Title 3'));

      // Popular movies
      expect(resultPopular, isA<List<Movie>>());
      expect(resultPopular.length, equals(3));

      expect(resultPopular[0].title, equals('Movie Title 1'));
      expect(resultPopular[1].title, equals('Movie Title 2'));
      expect(resultPopular[2].title, equals('Movie Title 3'));

      // Top Rated movies
      expect(resultTopRated, isA<List<Movie>>());
      expect(resultTopRated.length, equals(3));

      expect(resultTopRated[0].title, equals('Movie Title 1'));
      expect(resultTopRated[1].title, equals('Movie Title 2'));
      expect(resultTopRated[2].title, equals('Movie Title 3'));

      // Top Rated movies
      expect(resultUpcoming, isA<List<Movie>>());
      expect(resultUpcoming.length, equals(3));

      expect(resultUpcoming[0].title, equals('Movie Title 1'));
      expect(resultUpcoming[1].title, equals('Movie Title 2'));
      expect(resultUpcoming[2].title, equals('Movie Title 3'));
    });

    final movieDetailsResponse = {
      'adult': false,
      'backdrop_path': '/backdrop.jpg',
      'belongs_to_collection': {
        'id': 1,
        'name': 'Collection Name',
        'poster_path': '/collection_poster.jpg',
        'backdrop_path': '/collection_backdrop.jpg',
      },
      'budget': 1000000,
      'genres': [
        {'id': 28, 'name': 'Action'},
        {'id': 12, 'name': 'Adventure'},
      ],
      'homepage': 'https://example.com',
      'id': 123,
      'imdb_id': 'tt1234567',
      'original_language': 'en',
      'original_title': 'Original Title',
      'overview': 'Movie overview',
      'popularity': 7.5,
      'poster_path': '/poster.jpg',
      'production_companies': [
        {
          'id': 1,
          'logo_path': '/company_logo.jpg',
          'name': 'Production Company',
          'origin_country': 'Origin Company'
        },
      ],
      'production_countries': [
        {'iso_3166_1': 'US', 'name': 'United States'},
      ],
      'release_date': '2022-01-01',
      'revenue': 1500000,
      'runtime': 120,
      'spoken_languages': [
        {'english_name': 'English', 'iso_639_1': 'en', 'name': 'English'},
      ],
      'status': 'Released',
      'tagline': 'Movie Tagline',
      'title': 'Movie Title',
      'video': false,
      'vote_average': 8.0,
      'vote_count': 100,
    };

    test('should return a Movie when calling getMovieById', () async {
      const movieId = '123';
      dioAdapter.onGet('movie/$movieId', (server) {
        return server.reply(200, movieDetailsResponse);
      });

      //Act
      final result = await datasource.getMovieById(movieId);

      //Assert
      expect(result, isA<Movie>());
      expect(result.id, equals(123));
      expect(result.title, equals('Movie Title'));
    });

    test('should return a list of movies when calling searchMovies', () async {
      const query = 'Movie';
      dioAdapter.onGet('search/movie', (server) {
        return server.reply(200, moviesResponse);
      });

      //Act
      final result = await datasource.searchMovies(query);

      //Assert
      expect(result, isA<List<Movie>>());
      expect(result.length, equals(3));
      expect(result[0].title, equals('Movie Title 1'));
    });

    test('should return an empty list when search query is empty', () async {
      // Arrange
      const emptyQuery = '';

      // Act
      final result = await datasource.searchMovies(emptyQuery);

      // Assert
      expect(result, isA<List<Movie>>());
      expect(result, isEmpty);
    });

    test(
        'should return a list of YouTube videos when calling getYoutubeVideosById',
        () async {
      // Arrange
      const movieId = 123;
      final youtubeVideosResponse = {
        'id': movieId,
        'results': [
          {
            'iso_639_1': 'en',
            'iso_3166_1': 'US',
            'name': 'YouTube Video 1',
            'key': 'video_key_1',
            'site': 'YouTube',
            'size': 720,
            'type': 'Trailer',
            'official': true,
            'published_at': '2022-01-01T12:00:00Z',
            'id': 'video_id_1',
          },
          // Add more video entries as needed
        ],
      };

      dioAdapter.onGet('movie/$movieId/videos', (server) {
        return server.reply(200, youtubeVideosResponse);
      });

      // Act
      final result = await datasource.getYoutubeVideosById(movieId);

      // Assert
      expect(result, isA<List<Video>>());
      expect(result.length, equals(1));
      expect(result[0].name, equals('YouTube Video 1'));
    });
  });
}
