import 'dart:io';

import 'package:cinemapedia/data/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/data/models/models.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('ActorMovieDbDatasource', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());

    late ActorMovieDbDatasource datasource;
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
      datasource = ActorMovieDbDatasource();
      datasource.dio = dio;
    });

    test('should return a list of actors when calling getActorsByMovie',
        () async {
      // Arrange
      const movieId = '123';

      // Definir la respuesta simulada de la API
      final creditsResponse = CreditsResponse(
        id: 123,
        cast: [
          Cast(
            adult: false,
            gender: 2,
            id: 456,
            knownForDepartment: "Acting",
            name: "John Doe",
            originalName: "John Doe",
            popularity: 10.0,
            profilePath: "/path/to/profile.jpg",
            castId: 1,
            character: "Character Name",
            creditId: "abc123",
            order: 1,
            department: "Actors",
            job: "Actor",
          ),
        ],
        crew: [],
      );

      // Ruta de la solicitud
      const path = 'movie/$movieId/credits';
      //Configuración del adaptador de prueba para simular la respuesta de la API
      dioAdapter.onGet(
          path, (server) => server.reply(200, creditsResponse.toJson()));

      //Act
      //Realizar la simulación de la solicitud HTTP
      final response = await dio.get(path);

      // Llamar al método que estamos probando para obtener el resultado real
      final result = await datasource.getActorsByMovie(movieId);

      // Assert
      // Verificar que la respuesta HTTP tenga un código de estado 200
      expect(response.statusCode, equals(200));

      // Verificar que el resultado es una lista de actores
      expect(result, isA<List<Actor>>());

      // Verificar que la lista de actores tiene un tamaño de 1
      expect(result.length, equals(1));

      // Verificar propiedades específicas del actor en la lista
      final actor = result[0];
      expect(actor.name, equals('John Doe'));
      expect(actor.character, equals('Character Name'));

      // Asegurarse de que la lista de actores no esté vacía
      expect(result, isNotEmpty);
    });

    test('should handle error response when calling getActorsByMovie',
        () async {
      // Arrange
      const movieId = '123';
      const path = 'movie/$movieId/credits';

      // Configurar el adaptador de prueba para simular una respuesta de error (404 en este caso)
      dioAdapter.onGet(path, (server) => server.reply(404, 'Not Found'));

      // Act & Assert
      // Utilizar un bloque try-catch para manejar la excepción que se espera
      try {
        // Realizar la simulación de la solicitud HTTP
        await dio.get(path);

        // Llamar al método que estamos probando, debería lanzar una excepción
        await datasource.getActorsByMovie(movieId);

        // Si llegamos aquí, la prueba debería fallar porque no se lanzó la excepción esperada
        fail('Expected DioException but no exception was thrown');
      } catch (e) {
        // Verificar que la excepción sea de tipo DioException y que tenga el código de estado 404
        expect(e, isA<DioException>());
        expect((e as DioException).response?.statusCode, equals(404));
      }
    });
  });
}
