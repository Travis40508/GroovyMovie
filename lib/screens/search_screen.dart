import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/blocs/search_bloc.dart';
import 'package:groovy_movie/models/movies_res.dart';
import 'package:groovy_movie/utils/strings.dart';
import 'package:groovy_movie/widgets/empty_result_widget.dart';
import 'package:groovy_movie/widgets/error_widget.dart';
import 'package:groovy_movie/widgets/movie_tile.dart';
import 'package:groovy_movie/widgets/movies_loading_widget.dart';
import 'package:groovy_movie/widgets/stream_handler.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  SearchBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = BlocProvider.of<SearchBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            autofocus: true,
            style: Theme.of(context).textTheme.subtitle,
            cursorColor: Theme.of(context).primaryColor,
            controller: _controller,
            decoration: InputDecoration(
              labelText: Strings.searchLabel,
              hintText: Strings.searchHint,
              hintStyle: Theme.of(context).textTheme.subtitle,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => _controller.clear(),
              ),
            ),
            maxLines: 1,
            onChanged: (query) => _bloc.onTextChanged(query: query),
          ),
        ),
        StreamBuilder(
          initialData: false,
          stream: _bloc.loadingStream,
          builder: (context, AsyncSnapshot<bool> isLoading) {
            return isLoading.data ? MoviesLoadingWidget() : Container();
          },
        ),
        StreamBuilder(
          stream: _bloc.searchedMoviesStream,
          builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
            return StreamHandler(
                snapshot: snapshot,
                errorWidget: MoviesErrorWidget(),
                loadingWidget: Container(),
                emptyResultWidget: EmptyResultWidget(),
                successWidget: Expanded(
                  child: GridView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot?.data?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        Movie movie = snapshot?.data[index];

                        return MovieTile(
                          movie: movie,
                          imagePath: _bloc.fetchImagePath(
                              path: movie?.posterPath),
                        );
                      }),
                ));
          },
        ),
      ],
    );
  }
}
