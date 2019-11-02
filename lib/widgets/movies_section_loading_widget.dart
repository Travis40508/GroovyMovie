import 'package:flutter/material.dart';

class MoviesSectionLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),
    );
  }
}
