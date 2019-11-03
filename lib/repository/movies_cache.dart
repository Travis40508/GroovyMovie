import 'package:flutter/foundation.dart';
import 'package:groovy_movie/models/movies_res.dart';

///Interface for caching and retrieving movie information
abstract class MoviesCache {
  Future<MoviesRes> fetchMoviesFromCache({@required String key});
  void cacheMovies({@required String key, @required MoviesRes movies});
}