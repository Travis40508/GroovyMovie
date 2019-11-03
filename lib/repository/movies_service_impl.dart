

import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/repository/movies_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
export 'movies_service.dart';

class MoviesServiceImpl implements MoviesService {

  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _movieParam = '/movie';
  static const String _similarParam = '/similar';
  static const String _searchParam = '/search';
  static const String _queryParam = 'query=';
  static const String _apiKey = 'api_key=418f69f7c0d1fed486637082642b4e59';

  Client _client = Client();

  @override
  Future<MoviesRes> fetchMovies({@required String type}) async {
    final url = '$_baseUrl$_movieParam/$type?$_apiKey';
    final res = await _client.get(url);
    final json = jsonDecode(res.body);

    print('${DateTime.now()} - Fetching response from - $url');
    print('Response from - $url = $json');

    return MoviesRes.fromJson(json);
  }

  @override
  Future<MoviesRes> fetchSimilarMovies({int id}) async {
    final url = '$_baseUrl$_movieParam/$id$_similarParam?$_apiKey';
    final res = await _client.get(url);
    final json = jsonDecode(res.body);

    print('${DateTime.now()} - Fetching response from - $url');
    print('Response from - $url = $json');

    return MoviesRes.fromJson(json);
  }

  @override
  Future<MoviesRes> fetchSearchedMovies({String query}) async {
    final url = '$_baseUrl$_searchParam$_movieParam?$_apiKey&$_queryParam$query';
    final res = await _client.get(url);
    final json = jsonDecode(res.body);

    print('${DateTime.now()} - Fetching response from - $url');
    print('Response from - $url = $json');

    return MoviesRes.fromJson(json);
  }

}