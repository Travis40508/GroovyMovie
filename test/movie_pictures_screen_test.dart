import 'package:flutter_test/flutter_test.dart';
import 'package:groovy_movie/blocs/movie_images_bloc.dart';
import 'package:groovy_movie/repository/movies_repository_impl.dart';
import 'package:groovy_movie/utils/strings.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mock_objects.dart';
import 'mocks/mock_responses.dart';


void main() {

  MovieImagesBloc _bloc;
  MoviesRepository _repository;

  setUp(() {
    _repository = MockMoviesRepository();
    _bloc = MovieImagesBloc.withMocks(repository: _repository);
  });

  group('testing pictures', () {

    test('testing adding images from service call to stream', () {
      final _imagesRes = MockResponses.fetchMovieImages();

      expectLater(_bloc.movieImagesStream, emitsInOrder([
        emits(_imagesRes)
      ]));

      _bloc.populateImages(images: _imagesRes);
    });
  });
}