import 'package:flutter/material.dart';
import 'package:movie_app/features/domain/entities/movie.dart';

class TrendingList extends StatelessWidget {
  final List<Movie> movies;

  const TrendingList(this.movies);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.2,
      width: _screenSize.width * 0.2,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) => _card(ctx, movies[i], _screenSize),
        itemCount: movies.length,
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie, Size screenSize) {
    movie.cardId = '${movie.id}-poster';
    final card = Flexible(
      child: Container(
        width: screenSize.width * 0.25,
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movie.getImagePath()),
                  fit: BoxFit.cover,
                  height: 105.0,
                  width: 100.0,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontFamily: Theme.of(context).textTheme.caption.fontFamily,
                fontSize: Theme.of(context).textTheme.caption.fontSize,
              ),
            )
          ],
        ),
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () =>
          Navigator.pushNamed(context, '/movie-details', arguments: movie),
    );
  }
}
