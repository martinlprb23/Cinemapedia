import 'package:cinemapedia/data/mappers/mappers.dart';
import 'package:cinemapedia/data/models/models.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ActorMapper', () {
    test('should map Cast to Actor entity', () {
      // Arrange
      final cast = Cast(
        adult: false,
        gender: 2,
        id: 123,
        knownForDepartment: 'Acting',
        name: 'John Doe',
        originalName: 'John Doe',
        popularity: 7.8,
        profilePath: '/path/to/profile.jpg',
        castId: 456,
        character: 'Character Name',
        creditId: 'abc123',
        order: 1,
        department: 'Production',
        job: 'Director',
      );

      // Act
      final actorEntity = ActorMaper.castToEntity(cast);

      // Assert
      expect(actorEntity, isA<Actor>());
      expect(actorEntity.id, cast.id);
      expect(actorEntity.name, cast.name);
      expect(
        actorEntity.image,
        'https://image.tmdb.org/t/p/w500/${cast.profilePath}',
      );
      expect(actorEntity.character, cast.character);
    });
  });
}
