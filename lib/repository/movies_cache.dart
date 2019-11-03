import 'package:flutter/foundation.dart';
import 'package:groovy_movie/models/movies_res.dart';

abstract class MoviesCache {
  Future<MoviesRes> fetchMoviesFromCache({@required String key});
  void cacheMovies({@required String key, @required MoviesRes movies});
}