

import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:groovy_movie/repository/movies_repository_impl.dart';
import 'package:groovy_movie/utils/strings.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart';

class MovieImagesBloc extends Bloc {

  MoviesRepository repository = MoviesRepositoryImpl();
  static const _streamDelay = 500;

  final _movieImagesSubject = PublishSubject<List<String>>();
  Observable<List<String>> get movieImagesStream => _movieImagesSubject.stream;

  MovieImagesBloc();

  MovieImagesBloc.withMocks({this.repository});

  @override
  void dispose() {
    _movieImagesSubject.close();
  }


  void populateImages({@required List<String> images}) {
    //This delay is necessary because we're populating our bloc before our widget is drawn
    Future.delayed(Duration(milliseconds: _streamDelay), () => _movieImagesSubject.sink.add(images));
  }

  String fetchImageUrl({@required String imagePath}) {
    return '${Strings.baseMoviePath}$imagePath';
  }
}