
import 'package:flutter/foundation.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc extends Bloc {

  MoviesRepository moviesRepository;

  final _moviesSubject = PublishSubject<dynamic>();
  Observable<dynamic> get moviesStream => _moviesSubject.stream;

  void fetchMovies({@required String type}) {
    moviesRepository.fetchMovies(type: type)
        .listen((movies) => _moviesSubject.sink.add(movies), onError: (e) => _moviesSubject.sink.addError(e));
  }

  MoviesBloc.withMocks({@required MoviesRepository repository}) {
    this.moviesRepository = repository;
  }

  @override
  void dispose() {
    _moviesSubject.close();
  }
}