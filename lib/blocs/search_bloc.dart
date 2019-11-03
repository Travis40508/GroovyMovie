
import 'package:flutter/foundation.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:groovy_movie/repository/movies_repository_impl.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc {

  MoviesRepository repository = MoviesRepositoryImpl();

  final _searchedMoviesSubject = PublishSubject<List<Movie>>();
  Observable<List<Movie>> get searchedMoviesStream => _searchedMoviesSubject.stream;

  SearchBloc();

  SearchBloc.initWithMocks({@required this.repository});

  @override
  void dispose() {
    _searchedMoviesSubject.close();
  }

  void onTextChanged({@required String query}) {
    repository.searchMovies(query: query)
        .listen((movies) => _searchedMoviesSubject.sink.add(movies), onError: (e) {
        print(e);
        _searchedMoviesSubject.sink.addError(e);
    });
  }

}