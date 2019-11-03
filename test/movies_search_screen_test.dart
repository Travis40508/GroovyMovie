import 'package:flutter_test/flutter_test.dart';
import 'package:groovy_movie/blocs/search_bloc.dart';
import 'package:groovy_movie/repository/movies_repository_impl.dart';
import 'package:groovy_movie/utils/strings.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'mocks/mock_objects.dart';
import 'mocks/mock_responses.dart';


void main() {
  SearchBloc _bloc;
  MoviesRepository _repository;

  setUp(() {
    _repository = MockMoviesRepository();
    _bloc = SearchBloc.initWithMocks(repository: _repository);

  });

  group('test search', () {

    test('testing happy path', () {
      final searchRes = MockResponses.fetchMockMoviesResponse();
      when(_repository.searchMovies(query: 'stub')).thenAnswer((_) => Observable.just(searchRes));

      expectLater(_bloc.searchedMoviesStream, emitsInOrder([
        null,
        emits(searchRes)
      ]));

      _bloc.onTextChanged(query: 'stub');
    });

    test('testing error path', () {
      final errorRes = MockResponses.fetchMockMoviesResponse();
      when(_repository.searchMovies(query: 'stub')).thenAnswer((_) => Observable.error(errorRes));

      expectLater(_bloc.searchedMoviesStream, emitsInOrder([
        null,
        emitsError(errorRes)
      ]));

      _bloc.onTextChanged(query: 'stub');
    });

    test('testing search when field is empty', () {
      _bloc.onTextChanged(query: Strings.empty);
      
      expect(_bloc.debounce, null);
    });

  });

  group('fetching image path', () {

    test('fetching image path when not null', () {
      final path = '/stub';

      expect(_bloc.fetchImagePath(path: path), 'https://image.tmdb.org/t/p/w500/stub');
    });

    test('fetching image path when null', () {
      final path = null;

      expect(_bloc.fetchImagePath(path: path), Strings.noImageUrl);
    });
  });
}