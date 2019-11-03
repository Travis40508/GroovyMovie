import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/blocs/movie_details_bloc.dart';
import 'package:groovy_movie/routes/movies_details_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:groovy_movie/widgets/movie_details_card.dart';

class MovieDetailsScreen extends StatefulWidget {
  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  MovieDetailsRoute _route;
  MovieDetailsBloc _bloc;
  PageController _controller = PageController();

  @override
  void didChangeDependencies() {
    _route = ModalRoute.of(context).settings.arguments;
    _bloc = BlocProvider.of<MovieDetailsBloc>(context);
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
    );
  }

  Widget buildAppBar() {
    return AppBar(title: Text(_route?.movie?.title), centerTitle: true,);
  }

  Widget buildBody() {
    return ListView(
      children: <Widget>[
        Image(
          image: CachedNetworkImageProvider(
            _bloc.getImagePath(path: _route?.movie?.backDropPath)
          ),
        ), MovieDetailsCard(
          movie: _route?.movie,
        )
      ],
    );
  }

}
