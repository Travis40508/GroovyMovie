import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/blocs/movies_bloc.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/routes/movie_screen_route.dart';
import 'package:groovy_movie/routes/movies_details_route.dart';
import 'package:groovy_movie/routes/search_screen_route.dart';
import 'package:groovy_movie/widgets/drawer_item.dart';
import 'package:groovy_movie/widgets/error_widget.dart';
import 'package:groovy_movie/widgets/movie_card.dart';
import 'package:groovy_movie/widgets/movies_section_loading_widget.dart';
import 'package:groovy_movie/widgets/stream_handler.dart';

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
      title: Text(_bloc.fetchScreenTitle(movieType: _route?.movieType),), centerTitle: true,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: () => Navigator.pushNamed(context, SearchScreenRoute.routeName),)
      ],
    );
  }

  Widget buildBody() {
    return StreamBuilder(
      stream: _bloc.moviesStream,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        Widget successWidget = PageView.builder(
          controller: PageController(viewportFraction: 0.9),
          scrollDirection: Axis.horizontal,
          itemCount: snapshot?.data?.length,
          itemBuilder: (context, index) {
            Movie _movie = snapshot?.data[index];

            return MovieCard(
              imagePath: _bloc.fetchImagePath(moviePath: _movie.posterPath),
              onClick: () => Navigator.pushNamed(context, MovieDetailsRoute.routeName, arguments: MovieDetailsRoute(movie: _movie)),);
          },
        );

        return StreamHandler(
          snapshot: snapshot,
          errorWidget: MoviesErrorWidget(),
          loadingWidget: MoviesSectionLoadingWidget(),
          successWidget: successWidget,
        );
      },
    );
  }

  Widget buildDrawer() {
    return Opacity(
      opacity: .8,
      child: Drawer(
        child: Container(
          color: Theme.of(context).dialogBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _bloc.typeToTitleMap.entries.map((section) => DrawerItem(
              isCurrentItem: _bloc.isCurrentSection(section: _route?.movieType, title: section.value),
              onClick: () {
                if (!_bloc.isCurrentSection(section: _route?.movieType, title: section.value)) {
                  Navigator.pushReplacementNamed(
                      context, MovieScreenRoute.routeName,
                      arguments: MovieScreenRoute(movieType: section.key));
                } else {
                  Navigator.pop(context);
                }
              },
              title: section.value,)).toList()
          ),
        ),
      ),
    );
  }
}
