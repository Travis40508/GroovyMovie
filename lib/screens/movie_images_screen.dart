import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:groovy_movie/blocs/movie_images_bloc.dart';
import 'package:groovy_movie/routes/movie_images_route.dart';
import 'package:groovy_movie/routes/movie_screen_route.dart';
import 'package:groovy_movie/utils/strings.dart';
import 'package:groovy_movie/widgets/error_widget.dart';
import 'package:groovy_movie/widgets/movies_loading_widget.dart';
import 'package:groovy_movie/widgets/stream_handler.dart';

class MovieImagesScreen extends StatefulWidget {
  @override
  _MovieImagesScreenState createState() => _MovieImagesScreenState();
}

class _MovieImagesScreenState extends State<MovieImagesScreen> {

  MovieImagesBloc _bloc;
  MovieImagesRoute _route;

  @override
  void didChangeDependencies() {

    _route = ModalRoute.of(context).settings.arguments;

    if (_bloc == null) {
      _bloc = BlocProvider.of<MovieImagesBloc>(context);
      _bloc.populateImages(images: _route?.images);
    }

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
    return AppBar(
      title: Text(Strings.imagesTitle),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.home),
        onPressed: () => Navigator.popUntil(context, ModalRoute.withName(MovieScreenRoute.routeName)),
      ),
    );
  }

  Widget buildBody() {
    return StreamBuilder(
      stream: _bloc.movieImagesStream,
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        return StreamHandler(
          snapshot: snapshot,
          errorWidget: MoviesErrorWidget(),
          loadingWidget: Container(),
          successWidget:
          Stack(
            children: <Widget>[
              Image(
                image: CachedNetworkImageProvider(
                  _bloc.fetchImageUrl(imagePath: _route?.posterImage)
                ),
              ),
              ListView.builder(
                itemCount: snapshot?.data?.length,
                itemBuilder: (context, index) {
                  String imageUrl = snapshot?.data[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        _bloc.fetchImageUrl(imagePath: imageUrl)
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
