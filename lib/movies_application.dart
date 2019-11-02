import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/blocs/movies_bloc.dart';
import 'package:groovy_movie/screens/movies_screen.dart';
import 'package:groovy_movie/utils/strings.dart';

class MoviesApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.applicationName,
      home: BlocProvider(
        bloc: MoviesBloc(),
        child: MoviesScreen(),
      ),
    );
  }
}
