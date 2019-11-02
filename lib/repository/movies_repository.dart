import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

abstract class MoviesRepository {
  Observable<dynamic> fetchMovies({@required String type});

}