
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

  final _movieImagesSubject = BehaviorSubject<List<String>>();
  ValueObservable<List<String>> get movieImagesStream => _movieImagesSubject.stream;

  @override
  void dispose() {
    _similarMoviesSubject.close();
    _movieImagesSubject.close();
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

  void fetchMovieImages({@required int movieId}) {
    repository.fetchImages(movieId: movieId)
        .listen((images) => _movieImagesSubject.sink.add(images.length > 0 ? images : null), onError: (e) {
      _movieImagesSubject.sink.addError(e);
      print(e);
    });
  }

  MovieDetailsBloc.withMocks({@required this.repository});

  void fetchMovieInfo({@required int id}) async {
    fetchSimilarMovies(id: id);
    fetchMovieImages(movieId: id);
  }

}
