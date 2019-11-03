import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/blocs/movies_bloc.dart';
import 'package:groovy_movie/routes/movie_screen_route.dart';
import 'package:groovy_movie/routes/movies_details_route.dart';
import 'package:groovy_movie/screens/movie_details_screen.dart';
import 'package:groovy_movie/screens/movies_screen.dart';
import 'package:groovy_movie/utils/strings.dart';
import 'blocs/movie_details_bloc.dart';

class MoviesApplication extends StatelessWidget {

  final primaryColor = Colors.redAccent;
  final secondaryColor = Colors.black45;
  final drawerColor = Colors.black;

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
        ),

        MovieDetailsRoute.routeName: (context) => BlocProvider(
          bloc: MovieDetailsBloc(),
          child: MovieDetailsScreen(),
        )
      },

      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        backgroundColor: secondaryColor,
        dialogBackgroundColor: drawerColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: primaryColor
          ),
          color: Colors.transparent,
          textTheme: TextTheme(
            title: TextStyle(
              color: primaryColor,
              fontSize: 22.0
            )
          ),
        ),
        textTheme: TextTheme(
          caption: TextStyle(
            color: primaryColor,
            fontSize: 22.0,
          ),
          subtitle: TextStyle(
            color: primaryColor,
            fontSize: 16.0,
            fontWeight: FontWeight.normal
          ),
          title: TextStyle(
              color: primaryColor,
              fontSize: 28.0,
              fontWeight: FontWeight.bold
          ),
        )
      ),
    );
  }
}
