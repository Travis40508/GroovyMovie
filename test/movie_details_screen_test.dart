import 'package:flutter_test/flutter_test.dart';
import 'package:groovy_movie/blocs/movie_details_bloc.dart';
import 'package:groovy_movie/repository/movies_repository.dart';

import 'mocks/mock_objects.dart';

void main() {

  MovieDetailsBloc _bloc;
  MoviesRepository _repository;

  setUp(() {
    _repository = MockMoviesRepository();
    _bloc = MovieDetailsBloc.withMocks(repository: _repository);
  });

}