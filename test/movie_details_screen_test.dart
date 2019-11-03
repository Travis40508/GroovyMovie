import 'package:flutter_test/flutter_test.dart';
import 'package:groovy_movie/blocs/movie_details_bloc.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'mocks/mock_objects.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mock_responses.dart';

void main() {

  MovieDetailsBloc _bloc;
  MoviesRepository _repository;

  setUp(() {
    _repository = MockMoviesRepository();
    _bloc = MovieDetailsBloc.withMocks(repository: _repository);
  });

  group('similar movies', () {

    test('fetching similar movies happy path', () {
      final similarMoviesRes = MockResponses.fetchMockMoviesResponse();
      when(_repository.fetchSimilarMovies(id: 12)).thenAnswer((_) => Observable.just(similarMoviesRes));

      expectLater(_bloc.similarMoviesStream, emitsInOrder([
        emits(similarMoviesRes)
      ]));

      _bloc.fetchSimilarMovies(id: 12);
    });

    test('fetching similar movies error path', () {
      final similarMoviesRes = Error();
      when(_repository.fetchSimilarMovies(id: 12)).thenAnswer((_) => Observable.error(similarMoviesRes));

      expectLater(_bloc.similarMoviesStream, emitsInOrder([
        emitsError(similarMoviesRes)
      ]));

      _bloc.fetchSimilarMovies(id: 12);
    });
  });
}