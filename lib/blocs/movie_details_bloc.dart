
import 'package:flutter/foundation.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class MovieDetailsBloc extends Bloc {

  static const _baseMoviePath = 'https://image.tmdb.org/t/p/w500';

  @override
  void dispose() {
    // TODO: implement dispose
  }

  String getImagePath({@required String path}) {
    return '$_baseMoviePath$path';
  }

  void onBottomNavItemSelected({@required int itemIndex}) {

  }

}

class MovieDetailSections {
  static const movieDetails = 0;
  static const similarMovies = 1;
}

class MovieDetailTitles {
  static const movieDetails = 'Details';
  static const similarMovies = 'Similar Movies';
}