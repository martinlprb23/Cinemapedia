import 'package:cinemapedia/data/mappers/mappers.dart';
import 'package:cinemapedia/data/models/models.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieMapper', () {
    test('should map MovieMovieDB to Movie entity', () {
      // Arrange
      final movieDB = MovieMovieDB(
        adult: false,
        backdropPath: 'backdrop.jpg',
        genreIds: [1, 2, 3],
        id: 123,
        originalLanguage: 'en',
        originalTitle: 'Test Movie',
        overview: 'This is a test movie.',
        popularity: 7.8,
        posterPath: '/path/to/poster.jpg',
        releaseDate: DateTime(2022, 1, 10),
        title: 'Test Movie',
        video: true,
        voteAverage: 8.0,
        voteCount: 100,
      );

      // Act
      final movieEntity = MovieMapper.movieDBToEntity(movieDB);

      // Assert
      expect(movieEntity, isA<Movie>());
      expect(movieEntity.id, movieDB.id);
      expect(
        movieEntity.backdropPath,
        'https://image.tmdb.org/t/p/w500/${movieDB.backdropPath}',
      );
      expect(movieEntity.genreIds,
          movieDB.genreIds.map((e) => e.toString()).toList());
    });
  });

  group('MovieDetailsMapper', () {
    test('should map JSON to MovieDetails entity', () {
      // Arrange
      final json = {
        "adult": false,
        "backdrop_path": "/path/to/backdrop.jpg",
        "belongs_to_collection": {
          "id": 1,
          "name": "Collection Name",
          "poster_path": "/path/to/collection_poster.jpg",
          "backdrop_path": "/path/to/collection_backdrop.jpg",
        },
        "budget": 1000000,
        "genres": [
          {"id": 28, "name": "Action"},
          {"id": 12, "name": "Adventure"},
        ],
        "homepage": "http://www.example.com",
        "id": 123,
        "imdb_id": "tt1234567",
        "original_language": "en",
        "original_title": "Original Title",
        "overview": "This is the overview of the movie.",
        "popularity": 7.8,
        "poster_path": "/path/to/poster.jpg",
        "production_companies": [
          {
            "id": 1,
            "logo_path": "/path/to/company_logo.png",
            "name": "Company Name",
            "origin_country": "US"
          },
          {
            "id": 2,
            "logo_path": "/path/to/company_logo2.png",
            "name": "Another Company",
            "origin_country": "UK"
          },
        ],
        "production_countries": [
          {"iso_3166_1": "US", "name": "United States"},
          {"iso_3166_1": "UK", "name": "United Kingdom"},
        ],
        "release_date": "2022-01-10",
        "revenue": 2000000,
        "runtime": 120,
        "spoken_languages": [
          {"english_name": "English", "iso_639_1": "en", "name": "English"},
          {"english_name": "Spanish", "iso_639_1": "es", "name": "Español"},
        ],
        "status": "Released",
        "tagline": "Tagline of the movie",
        "title": "Test Movie",
        "video": true,
        "vote_average": 8.5,
        "vote_count": 500,
      };

      // Act
      final movieDetailsEntity = MovieDetails.fromJson(json);

      // Assert
      expect(movieDetailsEntity, isA<MovieDetails>());
      expect(movieDetailsEntity.adult, false);
      expect(movieDetailsEntity.backdropPath, "/path/to/backdrop.jpg");
      expect(
          movieDetailsEntity.belongsToCollection, isA<BelongsToCollection>());
      expect(movieDetailsEntity.budget, 1000000);
      expect(movieDetailsEntity.genres, isA<List<Genre>>());
      expect(movieDetailsEntity.homepage, "http://www.example.com");
      expect(movieDetailsEntity.id, 123);
      expect(movieDetailsEntity.imdbId, "tt1234567");
      expect(movieDetailsEntity.originalLanguage, "en");
      expect(movieDetailsEntity.originalTitle, "Original Title");
      expect(movieDetailsEntity.overview, "This is the overview of the movie.");
      expect(movieDetailsEntity.popularity, 7.8);
      expect(movieDetailsEntity.posterPath, "/path/to/poster.jpg");
      expect(movieDetailsEntity.productionCompanies,
          isA<List<ProductionCompany>>());
      expect(movieDetailsEntity.productionCountries,
          isA<List<ProductionCountry>>());
      expect(movieDetailsEntity.releaseDate, DateTime(2022, 1, 10));
      expect(movieDetailsEntity.revenue, 2000000);
      expect(movieDetailsEntity.runtime, 120);
      expect(movieDetailsEntity.spokenLanguages, isA<List<SpokenLanguage>>());
      expect(movieDetailsEntity.status, "Released");
      expect(movieDetailsEntity.tagline, "Tagline of the movie");
      expect(movieDetailsEntity.title, "Test Movie");
      expect(movieDetailsEntity.video, true);
      expect(movieDetailsEntity.voteAverage, 8.5);
      expect(movieDetailsEntity.voteCount, 500);
    });

    test('should map MovieDetails entity to JSON', () {
      // Arrange
      final movieDetailsEntity = MovieDetails(
        adult: false,
        backdropPath: "/path/to/backdrop.jpg",
        belongsToCollection: BelongsToCollection(
          id: 1,
          name: "Collection Name",
          posterPath: "/path/to/collection_poster.jpg",
          backdropPath: "/path/to/collection_backdrop.jpg",
        ),
        budget: 1000000,
        genres: [
          Genre(id: 28, name: "Action"),
          Genre(id: 12, name: "Adventure"),
        ],
        homepage: "http://www.example.com",
        id: 123,
        imdbId: "tt1234567",
        originalLanguage: "en",
        originalTitle: "Original Title",
        overview: "This is the overview of the movie.",
        popularity: 7.8,
        posterPath: "/path/to/poster.jpg",
        productionCompanies: [
          ProductionCompany(
              id: 1,
              logoPath: "/path/to/company_logo.png",
              name: "Company Name",
              originCountry: "US"),
          ProductionCompany(
              id: 2,
              logoPath: "/path/to/company_logo2.png",
              name: "Another Company",
              originCountry: "UK"),
        ],
        productionCountries: [
          ProductionCountry(iso31661: "US", name: "United States"),
          ProductionCountry(iso31661: "UK", name: "United Kingdom"),
        ],
        releaseDate: DateTime(2022, 1, 10),
        revenue: 2000000,
        runtime: 120,
        spokenLanguages: [
          SpokenLanguage(
              englishName: "English", iso6391: "en", name: "English"),
          SpokenLanguage(
              englishName: "Spanish", iso6391: "es", name: "Español"),
        ],
        status: "Released",
        tagline: "Tagline of the movie",
        title: "Test Movie",
        video: true,
        voteAverage: 8.5,
        voteCount: 500,
      );

      // Act
      final json = movieDetailsEntity.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
    });
  });
}
