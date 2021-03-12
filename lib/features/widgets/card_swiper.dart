import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_app/features/domain/entities/movie.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:movie_app/core/network/movie_db_client.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return Hero(
            tag: movies[index].id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/movie-details',
                  arguments: movies[index],
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: movies[index].getImagePath(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
