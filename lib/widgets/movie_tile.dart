import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/routes/movies_details_route.dart';
import 'package:groovy_movie/utils/strings.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final String imagePath;

  MovieTile({@required this.movie, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, MovieDetailsRoute.routeName,
              arguments: MovieDetailsRoute(movie: movie)),
          child: Image(
            image: CachedNetworkImageProvider(
              imagePath ?? Strings.noImageUrl,
            ),
          ),
        ));
  }
}
