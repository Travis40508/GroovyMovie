import 'package:flutter/foundation.dart';
import 'package:groovy_movie/models/movies_res.dart';

abstract class MoviesService {
  Future<MoviesRes> fetchMovies({@required String type});
  Future<MoviesRes> fetchSimilarMovies({@required int id});
}