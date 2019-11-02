import 'package:flutter_test/flutter_test.dart';
import 'package:groovy_movie/blocs/movies_bloc.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import 'mocks/mock_objects.dart';
import 'mocks/mock_responses.dart';

void main() {

  group('popular movies test', () {
    final MoviesRepository moviesRepository = MockMoviesRepository();
    final moviesBloc = MoviesBloc.withMocks(repository: moviesRepository);
    test('loading popular movies test', () {
      final moviesRes = MockResponses.fetchMockMoviesResponse();
      when(moviesRepository.fetchMovies(type: 'popular')).thenAnswer((_) => Observable.just(moviesRes));

      expectLater(moviesBloc.moviesStream, emitsInOrder([
        moviesRes
      ]));

      moviesBloc.fetchMovies(type: 'popular');
    });
  });
}