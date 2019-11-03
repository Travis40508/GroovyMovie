
import 'package:flutter/foundation.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsBloc extends Bloc {

  static const _baseMoviePath = 'https://image.tmdb.org/t/p/w500';
  MoviesRepository repository;

  MovieDetailsBloc();

  @override
  void dispose() {
  }

  String getImagePath({@required String path}) {
    return '$_baseMoviePath$path';
  }


  MovieDetailsBloc.withMocks({@required this.repository});

}

class MovieDetailSections {
  static const movieDetails = 0;
  static const similarMovies = 1;
}

class MovieDetailTitles {
  static const movieDetails = 'Details';
  static const similarMovies = 'Similar Movies';
}