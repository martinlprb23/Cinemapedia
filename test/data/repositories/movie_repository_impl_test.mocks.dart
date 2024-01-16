// Mocks generated by Mockito 5.4.4 from annotations
// in cinemapedia/test/data/repositories/movie_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cinemapedia/domain/datasources/movies_datasource.dart' as _i3;
import 'package:cinemapedia/domain/entities/movie.dart' as _i2;
import 'package:cinemapedia/domain/entities/video.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMovie_0 extends _i1.SmartFake implements _i2.Movie {
  _FakeMovie_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MoviesDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesDatasource extends _i1.Mock implements _i3.MoviesDatasource {
  @override
  _i4.Future<List<_i2.Movie>> getNowPlaying({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlaying,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<List<_i2.Movie>> getPopular({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopular,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<List<_i2.Movie>> getTopRated({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRated,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<List<_i2.Movie>> getUpcoming({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUpcoming,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<_i2.Movie> getMovieById(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i4.Future<_i2.Movie>.value(_FakeMovie_0(
          this,
          Invocation.method(
            #getMovieById,
            [id],
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.Movie>.value(_FakeMovie_0(
          this,
          Invocation.method(
            #getMovieById,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Movie>);

  @override
  _i4.Future<List<_i2.Movie>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<List<_i2.Movie>> getSimilarMovies(int? movieId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSimilarMovies,
          [movieId],
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<List<_i5.Video>> getYoutubeVideosById(int? movieId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getYoutubeVideosById,
          [movieId],
        ),
        returnValue: _i4.Future<List<_i5.Video>>.value(<_i5.Video>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i5.Video>>.value(<_i5.Video>[]),
      ) as _i4.Future<List<_i5.Video>>);
}
