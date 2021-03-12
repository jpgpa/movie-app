import 'package:flutter/material.dart';
import 'package:movie_app/features/domain/entities/movie.dart';

class MovieDetails extends StatelessWidget {
  static const routeName = '/movie-details';

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10.0,
                ),
                _titlePost(context, movie),
                _description(movie),
                _description(movie),
                _description(movie),
                _description(movie),
                _description(movie),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.amber,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getImagePath()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _titlePost(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getImagePath()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily:
                        Theme.of(context).textTheme.headline6.fontFamily,
                    fontSize: Theme.of(context).textTheme.headline6.fontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.getDateAsString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily:
                        Theme.of(context).textTheme.subtitle1.fontFamily,
                    fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
