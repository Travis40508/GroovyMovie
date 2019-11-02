import 'package:flutter/material.dart';
import 'package:groovy_movie/utils/strings.dart';

class MoviesErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Strings.errorLoadingText,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
    );
  }
}
