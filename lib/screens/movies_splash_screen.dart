import 'package:flutter/material.dart';
import 'package:groovy_movie/routes/movie_screen_route.dart';
import 'package:groovy_movie/utils/strings.dart';

class MoviesSplashScreen extends StatefulWidget {
  @override
  _MoviesSplashScreenState createState() => _MoviesSplashScreenState();
}

class _MoviesSplashScreenState extends State<MoviesSplashScreen> {

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, MovieScreenRoute.routeName));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.movie, size: 100.0, color: Theme.of(context).primaryColor,),
            Text(
              Strings.applicationName,
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
