import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/blocs/movies_bloc.dart';
import 'package:groovy_movie/routes/movie_screen_route.dart';
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

      routes: {
        MovieScreenRoute.routeName: (context) => BlocProvider(
          bloc: MoviesBloc(),
          child: MoviesScreen(),
        )
      },

      theme: ThemeData(
        primaryColor: Colors.redAccent,
        backgroundColor: Colors.black45,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.redAccent
          ),
          color: Colors.transparent
        ),
      ),
    );
  }
}
