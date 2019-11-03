
import 'package:groovy_movie/models/movies_res.dart';

class MockResponses {

  static List<Movie> fetchMockMoviesResponse() {
    Movie firstMovie = Movie(null, null, null, null, null, null, null, null);
    Movie secondMovie = Movie(null, null, null, null, null, null, null, null);

    List<Movie> mockMovies = List();

    mockMovies.addAll([firstMovie, secondMovie]);

    return mockMovies;
  }

  static List<Movie> fetchEmptyMoviesResponse() {
    List<Movie> mockMovies = List();

    return mockMovies;
  }
}