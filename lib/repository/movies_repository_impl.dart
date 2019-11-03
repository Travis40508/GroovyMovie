import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/repository/movies_cache_impl.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:groovy_movie/repository/movies_service_impl.dart';
export 'movies_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class MoviesRepositoryImpl implements MoviesRepository {

  static final MoviesRepository _instance = MoviesRepositoryImpl._internal();
  final MoviesService _moviesService = MoviesServiceImpl();
  final MoviesCache _moviesCache = MoviesCacheImpl();

  factory MoviesRepositoryImpl() {
    return _instance;
  }

  MoviesRepositoryImpl._internal();

  @override
  Observable<List<Movie>> fetchMovies({@required String type}) {
    return Observable.fromFuture(_moviesCache.fetchMoviesFromCache(key: type))
        .flatMap((res) => res != null ? Observable.just(res) : Observable.fromFuture(_moviesService.fetchMovies(type: type)))
        .doOnData((res) => _moviesCache.cacheMovies(key: type, movies: res))
        .map((res) => res.movies);
  }

  @override
  Observable<List<Movie>> fetchSimilarMovies({int id}) {
    return Observable.fromFuture(_moviesCache.fetchMoviesFromCache(key: id.toString()))
        .flatMap((res) => res != null ? Observable.just(res) : Observable.fromFuture(_moviesService.fetchSimilarMovies(id: id)))
        .doOnData((res) => _moviesCache.cacheMovies(key: id.toString(), movies: res))
        .map((res) => res.movies);
  }
}
