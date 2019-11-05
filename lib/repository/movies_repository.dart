import 'package:flutter/foundation.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:rxdart/rxdart.dart';

///Interface for retrieving movie data
abstract class MoviesRepository {
  Observable<List<Movie>> fetchMovies({@required String type});
  Observable<List<Movie>> fetchSimilarMovies({@required int id});
  Observable<List<Movie>> searchMovies({@required String query});
  Observable<List<String>> fetchImages({@required int movieId});
}