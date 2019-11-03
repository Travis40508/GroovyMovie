
import 'package:flutter/foundation.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/repository/movies_repository.dart';
import 'package:groovy_movie/repository/movies_repository_impl.dart';
import 'package:groovy_movie/utils/strings.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsBloc extends Bloc {

  MoviesRepository repository = MoviesRepositoryImpl();

  MovieDetailsBloc();

  final _similarMoviesSubject = PublishSubject<List<Movie>>();
  Observable<List<Movie>> get similarMoviesStream => _similarMoviesSubject.stream;

  @override
  void dispose() {
    _similarMoviesSubject.close();
  }

  String getImagePath({@required String path}) {
    return path != null ? '${Strings.baseMoviePath}$path' : Strings.noImageUrl;
  }

  void fetchSimilarMovies({@required int id}) {
    repository.fetchSimilarMovies(id: id)
        .listen((movies) {
          movies.removeWhere((movie) => movie.posterPath == null);
      _similarMoviesSubject.sink.add(movies);
    }, onError: (e) {
       print(e);
       _similarMoviesSubject.sink.addError(e);
    });
  }

  MovieDetailsBloc.withMocks({@required this.repository});

}
