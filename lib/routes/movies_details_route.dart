import 'package:flutter/foundation.dart';
import 'package:groovy_movie/models/movies_res.dart';

class MovieDetailsRoute {
  static const routeName = '/movie_details_route';

  final Movie movie;

  MovieDetailsRoute({@required this.movie});
}