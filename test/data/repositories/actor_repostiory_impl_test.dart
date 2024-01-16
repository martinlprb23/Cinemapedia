import 'package:cinemapedia/data/repositories/actor_repostiory_impl.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('actor repostiory impl ...', () async {
    final datasource = MockActorDatasource();
    final actorRepo = ActorRepoImpl(datasource: datasource);

    //Act
    const movieId = '012';
    final actors = await actorRepo.getActorsByMovie(movieId);

    //Assert
    expect(actors, isNotNull);
    expect(actors.length, 1);
    final actor = actors[0];
    expect(actor.id, equals(123));
    expect(actor.name, equals("Martin Robles"));
  });
}

class MockActorDatasource implements ActorsDataSource {
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    List<Actor> actorsList = [];
    final actor = Actor(
        id: 123,
        name: 'Martin Robles',
        image: '/img_path.png',
        character: 'extra');
    actorsList.add(actor);
    return Future.value(actorsList);
  }
}
