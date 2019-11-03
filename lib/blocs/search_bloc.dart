import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:groovy_movie/repository/movies_repository_impl.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc {
  MoviesRepository repository = MoviesRepositoryImpl();
  static const _baseMoviePath = 'https://image.tmdb.org/t/p/w500';
  Timer debounce;
  static const int INPUT_DELAY = 750;

  final _searchedMoviesSubject = PublishSubject<List<Movie>>();

  Observable<List<Movie>> get searchedMoviesStream =>
      _searchedMoviesSubject.stream;

  final _loadingSubject = PublishSubject<bool>();

  Observable<bool> get loadingStream => _loadingSubject.stream;

  SearchBloc();

  SearchBloc.initWithMocks({@required this.repository});

  @override
  void dispose() {
    _searchedMoviesSubject.close();
    _loadingSubject.close();
  }

  void onTextChanged({@required String query}) {
    if (debounce?.isActive ?? false) {
      debounce.cancel();
    }

    if (query.length > 0) {
      debounce = Timer(const Duration(milliseconds: INPUT_DELAY), () {
        _loadingSubject.sink.add(true);
        _searchedMoviesSubject.sink.add(null);

        repository.searchMovies(query: query).listen((movies) {
          _searchedMoviesSubject.sink.add(movies);
          _loadingSubject.sink.add(false);
        }, onError: (e) {
          print(e);
          _searchedMoviesSubject.sink.addError(e);
          _loadingSubject.sink.add(false);
        });
      });
    }
  }

  String fetchImagePath({@required String path}) {
    return '$_baseMoviePath$path';
  }
}
