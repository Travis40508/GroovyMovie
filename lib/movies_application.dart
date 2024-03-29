
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/blocs/movie_images_bloc.dart';
import 'package:groovy_movie/blocs/movies_bloc.dart';
import 'package:groovy_movie/blocs/search_bloc.dart';
import 'package:groovy_movie/routes/movie_images_route.dart';
import 'package:groovy_movie/routes/movie_screen_route.dart';
import 'package:groovy_movie/routes/movies_details_route.dart';
import 'package:groovy_movie/routes/search_screen_route.dart';
import 'package:groovy_movie/screens/movie_details_screen.dart';
import 'package:groovy_movie/screens/movie_images_screen.dart';
import 'package:groovy_movie/screens/movies_screen.dart';
import 'package:groovy_movie/screens/movies_splash_screen.dart';
import 'package:groovy_movie/screens/search_screen.dart';
import 'package:groovy_movie/utils/strings.dart';
import 'blocs/movie_details_bloc.dart';

class MoviesApplication extends StatelessWidget {

  final primaryColor = Colors.redAccent;
  final secondaryColor = Colors.black45;
  final drawerColor = Colors.black;

  @override
  Widget build(BuildContext context) {

    ///Locks screen to Portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.applicationName,
      home: MoviesSplashScreen(),

      routes: {
        MovieScreenRoute.routeName: (context) => BlocProvider(
          bloc: MoviesBloc(),
          child: MoviesScreen(),
        ),

        MovieDetailsRoute.routeName: (context) => BlocProvider(
          bloc: MovieDetailsBloc(),
          child: MovieDetailsScreen(),
        ),

        SearchScreenRoute.routeName: (context) => BlocProvider(
          bloc: SearchBloc(),
          child: SafeArea(child: SearchScreen()),
        ),

        MovieImagesRoute.routeName: (context) => BlocProvider(
          bloc: MovieImagesBloc(),
          child: MovieImagesScreen(),
        )
      },

      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        backgroundColor: secondaryColor,
        dialogBackgroundColor: drawerColor,
        textSelectionHandleColor: primaryColor,
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
            fontStyle: FontStyle.italic,
          ),
          subtitle: TextStyle(
            color: primaryColor,
            fontStyle: FontStyle.italic,
            fontSize: 16.0,
          ),
          title: TextStyle(
              color: primaryColor,
              fontSize: 28.0,
              fontWeight: FontWeight.bold
          ),
          headline: TextStyle(
            color: primaryColor,
            fontSize: 48.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        )
      ),
    );
  }
}
