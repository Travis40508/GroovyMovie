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

  group('movie images', () {

    test('fetching movie images happy path', () {
      final movieImagesRes = MockResponses.fetchMovieImages();
      when(_repository.fetchImages(movieId: 12)).thenAnswer((_) => Observable.just(movieImagesRes));

      expectLater(_bloc.movieImagesStream, emitsInOrder([
        emits(movieImagesRes)
      ]));

      _bloc.fetchMovieImages(movieId: 12);
    });

    test('fetching movie images happy path no images', () {
      //empty list
      final movieImagesRes = List<String>();
      when(_repository.fetchImages(movieId: 12)).thenAnswer((_) => Observable.just(movieImagesRes));

      expectLater(_bloc.movieImagesStream, emitsInOrder([
        emits(null)
      ]));

      _bloc.fetchMovieImages(movieId: 12);
    });

    test('fetching movie images error path', () {
      //empty list
      final errorRes = Error();
      when(_repository.fetchImages(movieId: 12)).thenAnswer((_) => Observable.error(errorRes));

      expectLater(_bloc.movieImagesStream, emitsInOrder([
        emitsError(errorRes)
      ]));

      _bloc.fetchMovieImages(movieId: 12);
    });
  });
}