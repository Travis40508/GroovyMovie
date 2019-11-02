import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/blocs/movies_bloc.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/routes/movie_screen_route.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  MoviesBloc _bloc;
  MovieScreenRoute _route;

  @override
  void didChangeDependencies() {
    _bloc = BlocProvider.of<MoviesBloc>(context);
    _route = ModalRoute.of(context).settings.arguments;

    _bloc.fetchMovies(type: _bloc.getMovieType(type: _route?.movieType));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: buildDrawer(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text(
        _bloc.fetchScreenTitle(title: _route?.movieType),
        style: TextStyle(color: Colors.redAccent),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).appBarTheme.color,
    );
  }

  Widget buildBody() {
    return StreamBuilder(
      stream: _bloc.moviesStream,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (!snapshot.hasData) {
          return Container();
        }

        return PageView.builder(
          controller: PageController(viewportFraction: 0.9),
          scrollDirection: Axis.horizontal,
          itemCount: snapshot?.data?.length,
          itemBuilder: (context, index) {
            Movie _movie = snapshot?.data[index];

            return Opacity(
              opacity: .85,
              child: Center(
                child: Container(
                  child: Card(
                    elevation: 8.0,
                    child: Image(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        _bloc.fetchImagePath(moviePath: _movie.posterPath),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildDrawer() {
    return Opacity(
      opacity: .8,
      child: Container(
        child: Column(
          children: <Widget>[
            Text('hi',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white
            ),),
            Text('bye')
          ],
        ),
      ),
    );
  }
}
