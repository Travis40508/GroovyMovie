
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/repository/movies_cache.dart';

class MoviesCacheImpl implements MoviesCache {

  Map<String, MoviesRes> _cache = Map();

  @override
  void cacheMovies({String movieType, MoviesRes movies}) {
    _cache.putIfAbsent(movieType, () => movies);
  }

  @override
  Future<MoviesRes> fetchMoviesFromCache({String movieType}) async {
    return _cache[movieType];
  }

}