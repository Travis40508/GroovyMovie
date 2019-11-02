import 'package:flutter_test/flutter_test.dart';
import 'package:groovy_movie/blocs/movies_bloc.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import 'mocks/mock_objects.dart';
import 'mocks/mock_responses.dart';

void main() {

  MoviesRepository moviesRepository;
  MoviesBloc moviesBloc;
  List<Movie> moviesRes;
  Error errorRes;

  setUp(() {
    moviesRepository = MockMoviesRepository();
    moviesBloc = MoviesBloc.withMocks(repository: moviesRepository);
    moviesRes = MockResponses.fetchMockMoviesResponse();
    errorRes = Error();
  });

  group('popular movies test', () {
    test('loading popular movies happy path test', () {
      when(moviesRepository.fetchMovies(type: 'popular')).thenAnswer((_) => Observable.just(moviesRes));

      expect(moviesBloc.moviesStream, emitsInOrder([
        emits(moviesRes)
      ]));

      moviesBloc.fetchMovies(type: 'popular');
    });

    test('loading popular movies error path test', () {
      when(moviesRepository.fetchMovies(type: 'popular')).thenAnswer((_) => Observable.error(errorRes));

      expect(moviesBloc.moviesStream, emitsInOrder([
        emitsError(errorRes)
      ]));

      moviesBloc.fetchMovies(type: 'popular');
    });

    test('fetch movie path', () {
      final moviePathMock = '/stub';

      expect(moviesBloc.fetchImagePath(moviePath: moviePathMock), 'https://image.tmdb.org/t/p/w500/stub');
    });

    test('popular movies title when type is null', () {
      final movieType = null;

      expect(moviesBloc.fetchScreenTitle(movieType: movieType), MovieTitles.popularMoviesTitle);
    });

    test('popular movies title when type is not null', () {

      expect(moviesBloc.fetchScreenTitle(movieType: MovieTypes.popularMovies), MovieTitles.popularMoviesTitle);
      expect(moviesBloc.fetchScreenTitle(movieType: MovieTypes.upcomingMovies), MovieTitles.upcomingMoviesTitle);
      expect(moviesBloc.fetchScreenTitle(movieType: MovieTypes.topRatedMovies), MovieTitles.topRatedMoviesTitle);
      expect(moviesBloc.fetchScreenTitle(movieType: MovieTypes.nowPlayingMovies), MovieTitles.nowPlayingMoviesTitle);
      expect(moviesBloc.fetchScreenTitle(movieType: 'default stub'), MovieTitles.popularMoviesTitle);
    });

    test('getting popular movie type when null', () {
      expect(moviesBloc.getMovieType(type: null), MovieTypes.popularMovies);
    });

    test('getting correct movie type when not null', () {
      expect(moviesBloc.getMovieType(type: MovieTypes.popularMovies), MovieTypes.popularMovies);
      expect(moviesBloc.getMovieType(type: MovieTypes.upcomingMovies), MovieTypes.upcomingMovies);
      expect(moviesBloc.getMovieType(type: MovieTypes.topRatedMovies), MovieTypes.topRatedMovies);
      expect(moviesBloc.getMovieType(type: MovieTypes.nowPlayingMovies), MovieTypes.nowPlayingMovies);
    });

    test('test if current section is selected if null', () {
      expect(moviesBloc.isCurrentSection(section: null, title: MovieTitles.popularMoviesTitle), true);
    });

    test('test if current section is selected if not null', () {
      expect(moviesBloc.isCurrentSection(section: MovieTypes.popularMovies, title: MovieTitles.popularMoviesTitle), true);
      expect(moviesBloc.isCurrentSection(section: MovieTypes.upcomingMovies, title: MovieTitles.upcomingMoviesTitle), true);
      expect(moviesBloc.isCurrentSection(section: MovieTypes.topRatedMovies, title: MovieTitles.topRatedMoviesTitle), true);
      expect(moviesBloc.isCurrentSection(section: MovieTypes.nowPlayingMovies, title: MovieTitles.nowPlayingMoviesTitle), true);
    });
  });
}