

class MoviesRes {
  final int _page;
  final int _totalResults;
  final List<Movie> _movies;

  MoviesRes.fromJson(Map<String, dynamic> parsedJson)
    : _page = parsedJson['page'],
      _totalResults = parsedJson['total_results'],
      _movies = (parsedJson['results'] as List).map((movie) => Movie.fromJson(movie)).toList();

  List<Movie> get movies => _movies;

  int get totalResults => _totalResults;

  int get page => _page;
}

class Movie {
  final String _posterPath;
  final _id;
  final String _backDropPath;
  final String _title;
  final List _genreIds;
  final _rating;
  final String _description;
  final String _releaseDate;

  //default constructor
  Movie(this._posterPath, this._id, this._backDropPath, this._title, this._genreIds, this._rating, this._description, this._releaseDate);

  Movie.fromJson(Map<String, dynamic> parsedJson)
    : _posterPath = parsedJson['poster_path'],
      _id = parsedJson['id'],
      _backDropPath = parsedJson['backdrop_path'],
      _title = parsedJson['title'],
      _genreIds = (parsedJson['genre_ids'] as List).map((id) => id).toList(),
      _rating = parsedJson['vote_average'],
      _description = parsedJson['overview'],
      _releaseDate = parsedJson['release_date'];

  String get releaseDate => _releaseDate;

  String get description => _description;

  get rating => _rating;

  List get genreIds => _genreIds;

  String get title => _title;

  String get backDropPath => _backDropPath;

  get id => _id;

  String get posterPath => _posterPath;

}