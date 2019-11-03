
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/repository/movies_cache.dart';
export 'movies_cache.dart';

class MoviesCacheImpl implements MoviesCache {

  Map<String, MoviesRes> _cache = Map();

  @override
  void cacheMovies({String key, MoviesRes movies}) {
    _cache.putIfAbsent(key, () => movies);
  }

  @override
  Future<MoviesRes> fetchMoviesFromCache({String key}) async {
    return _cache[key];
  }

}