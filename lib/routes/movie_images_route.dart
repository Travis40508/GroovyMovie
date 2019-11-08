import 'package:flutter/foundation.dart';

class MovieImagesRoute {
  static const routeName = '/movie_images_route';

  final List<String> images;
  final String posterImage;

  MovieImagesRoute({@required this.images, @required this.posterImage});
}