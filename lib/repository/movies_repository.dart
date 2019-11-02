import 'package:flutter/foundation.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:rxdart/rxdart.dart';

abstract class MoviesRepository {
  Observable<List<Movie>> fetchMovies({@required String type});

}