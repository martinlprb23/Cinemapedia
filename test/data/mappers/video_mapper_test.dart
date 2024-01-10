import 'package:cinemapedia/data/mappers/mappers.dart';
import 'package:cinemapedia/data/models/moviedb/moviedb_videos.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VideoMapper', () {
    test('should map moviedbVideo to Video entity', () {
      // Arrange
      final moviedbVideo = Result(
        iso6391: 'en',
        iso31661: 'US',
        name: 'Test Movie',
        key: 'test_key',
        site: 'YouTube',
        size: 720,
        type: 'Trailer',
        official: true,
        publishedAt: DateTime(2022, 1, 10),
        id: '123456',
      );

      // Act
      final videoEntity = VideoMapper.moviedbVideoToEntity(moviedbVideo);

      // Assert
      expect(videoEntity, isA<Video>());
      expect(videoEntity.id, moviedbVideo.id);
      expect(videoEntity.name, moviedbVideo.name);
      expect(videoEntity.youtubeKey, moviedbVideo.key);
      expect(videoEntity.publishedAt, moviedbVideo.publishedAt);
    });
  });
}
