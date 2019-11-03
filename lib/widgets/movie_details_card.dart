import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/utils/strings.dart';

class MovieDetailsCard extends StatelessWidget {

  final Movie movie;

  MovieDetailsCard({@required this.movie});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            movie?.description,
            style: Theme.of(context).textTheme.subtitle,
            textAlign: TextAlign.justify,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${Strings.releaseDate}${movie?.releaseDate}',
            style: Theme.of(context).textTheme.subtitle,
            textAlign: TextAlign.justify,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(
                '${Strings.rating}${movie?.rating?.toString()}',
                style: Theme.of(context).textTheme.subtitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
