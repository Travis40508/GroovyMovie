import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/blocs/movie_details_bloc.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/routes/movies_details_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:groovy_movie/utils/strings.dart';
import 'package:groovy_movie/widgets/error_widget.dart';
import 'package:groovy_movie/widgets/movie_details_card.dart';
import 'package:groovy_movie/widgets/movies_section_loading_widget.dart';
import 'package:groovy_movie/widgets/stream_handler.dart';

class MovieDetailsScreen extends StatefulWidget {
  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  MovieDetailsRoute _route;
  MovieDetailsBloc _bloc;

  @override
  void didChangeDependencies() {
    _route = ModalRoute.of(context).settings.arguments;
    _bloc = BlocProvider.of<MovieDetailsBloc>(context);

    _bloc.fetchSimilarMovies(id: _route?.movie?.id);
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
      shrinkWrap: true,
      children: <Widget>[
        Image(
          image: CachedNetworkImageProvider(
            _bloc.getImagePath(path: _route?.movie?.backDropPath)
          ),
        ), MovieDetailsCard(
          movie: _route?.movie,
        ),
        StreamBuilder(
          stream: _bloc.similarMoviesStream,

          builder: (context, AsyncSnapshot<List<Movie>> snapshot) {

            return StreamHandler(
              snapshot: snapshot,
              errorWidget: MoviesErrorWidget(),
              loadingWidget: MoviesSectionLoadingWidget(),
              successWidget: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Strings.similarMoviesCaption,
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GridView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                      itemCount: snapshot?.data?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        Movie _similarMovie = snapshot?.data[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: CachedNetworkImageProvider(
                              _bloc.getImagePath(path: _similarMovie?.posterPath)
                            ),
                          ),
                        );
                      }
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

}
