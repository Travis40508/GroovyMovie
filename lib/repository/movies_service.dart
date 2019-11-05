import 'package:flutter/foundation.dart';
import 'package:groovy_movie/models/movie_images_res.dart';
import 'package:groovy_movie/models/movies_res.dart';

///Interface for making API calls for retrieving movie data
abstract class MoviesService {
  Future<MoviesRes> fetchMovies({@required String type});
  Future<MoviesRes> fetchSimilarMovies({@required int id});
  Future<MoviesRes> fetchSearchedMovies({@required String query});
  Future<MovieImagesRes> fetchMovieImages({@required int movieId});
}