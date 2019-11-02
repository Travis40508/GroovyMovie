
import 'package:flutter/foundation.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:groovy_movie/repository/movies_repository_impl.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc extends Bloc {

  MoviesRepository moviesRepository = MoviesRepositoryImpl();
  static const _baseMoviePath = 'https://image.tmdb.org/t/p/w500';

  final _moviesSubject = PublishSubject<List<Movie>>();
  Observable<List<Movie>> get moviesStream => _moviesSubject.stream;

  void fetchMovies({@required String type}) async {
    moviesRepository.fetchMovies(type: type)
        .listen((movies) => _moviesSubject.sink.add(movies), onError: (e) {
      _moviesSubject.sink.addError(e);
      print('fetchMovies - $e');
    });
  }

  //default constructor
  MoviesBloc();

  MoviesBloc.withMocks({@required MoviesRepository repository}) {
    this.moviesRepository = repository;
  }

  @override
  void dispose() {
    _moviesSubject.close();
  }

  String fetchImagePath({@required String moviePath}) {
    return '$_baseMoviePath$moviePath';
  }

  String fetchScreenTitle({@required String movieType}) {
    switch (movieType) {
      case MovieTypes.popularMovies:
        return MovieTitles.popularMoviesTitle;
      case MovieTypes.nowPlayingMovies:
        return MovieTitles.nowPlayingMoviesTitle;
      case MovieTypes.topRatedMovies:
        return MovieTitles.topRatedMoviesTitle;
      case MovieTypes.upcomingMovies:
        return MovieTitles.upcomingMoviesTitle;
      default:
        return MovieTitles.popularMoviesTitle;
    }
  }

  String getMovieType({String type}) {
    return type?? MovieTypes.popularMovies;
  }

}

class MovieTypes {
  static const popularMovies = 'popular';
  static const nowPlayingMovies = 'now_playing';
  static const topRatedMovies = 'top_rated';
  static const upcomingMovies = 'upcoming';
}

class MovieTitles {
  static const popularMoviesTitle = 'Popular Movies';
  static const nowPlayingMoviesTitle = 'Now Playing';
  static const topRatedMoviesTitle = 'Top Rated';
  static const upcomingMoviesTitle = 'Upcoming Movies';
}