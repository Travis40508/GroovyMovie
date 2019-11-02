import 'package:flutter/foundation.dart';
import 'package:groovy_movie/models/movies_res.dart';

abstract class MoviesCache {
  Future<MoviesRes> fetchMoviesFromCache({@required String movieType});
  void cacheMovies({@required String movieType, @required MoviesRes movies});
}