import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:groovy_movie/repository/movies_service_impl.dart';
export 'movies_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesService _moviesService = MoviesServiceImpl();

  @override
  Observable<List<Movie>> fetchMovies({@required String type}) {
    return Observable.fromFuture(_moviesService.fetchMovies(type: type))
        .map((res) => res.movies);
  }
}
