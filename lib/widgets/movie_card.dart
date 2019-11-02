import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MovieCard extends StatelessWidget {

  final String imagePath;
  final VoidCallback onClick;

  MovieCard({@required this.imagePath, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: MediaQuery.of(context).size.height * .95,
          child: Card(
            elevation: 8.0,
            child: Image(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                imagePath
              ),
            ),
          ),
        ),
      ),
    );
  }
}
