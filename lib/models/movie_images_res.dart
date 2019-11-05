

class MovieImagesRes {

  final _id;
  final List<ImageBackDrops> _imageBackDrops;
  final List<ImagePosters> _imagePosters;

  MovieImagesRes.fromJson(Map<String, dynamic> parsedJson)
    : _id = parsedJson['id'],
      _imageBackDrops = (parsedJson['backdrops'] as List).map((image) => ImageBackDrops.fromJson(image)).toList(),
      _imagePosters = (parsedJson['posters'] as List).map((image) => ImagePosters.fromJson(image)).toList();

  List<ImagePosters> get imagePosters => _imagePosters;

  List<ImageBackDrops> get imageBackDrops => _imageBackDrops;

  get id => _id;

}

class ImageBackDrops {

  final String _imagePath;

  ImageBackDrops.fromJson(Map<String, dynamic> parsedJson)
      : _imagePath = parsedJson['file_path'];

  String get imagePath => _imagePath;
}

class ImagePosters {

  final String _imagePath;

  ImagePosters.fromJson(Map<String, dynamic> parsedJson)
    : _imagePath = parsedJson['file_path'];

  String get imagePath => _imagePath;

}