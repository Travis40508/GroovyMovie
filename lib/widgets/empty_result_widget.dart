import 'package:flutter/material.dart';
import 'package:groovy_movie/utils/strings.dart';

class EmptyResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Center(
        child: Text(
          Strings.emptyResultText,
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
