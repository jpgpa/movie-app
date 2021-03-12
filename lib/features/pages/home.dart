import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/bloc/list_state.dart';
import 'package:movie_app/features/bloc/blocs/popular_movies_bloc.dart';
import 'package:movie_app/features/bloc/blocs/top_rated_movies_bloc.dart';
import 'package:movie_app/features/bloc/events/popular_movies_event.dart';
import 'package:movie_app/features/bloc/events/top_rated_movies_event.dart';
import 'package:movie_app/features/domain/entities/movie_list.dart';
import 'package:movie_app/features/widgets/card_swiper.dart';
import 'package:movie_app/features/widgets/loading/loading_card_swiper.dart';
import 'package:movie_app/features/widgets/loading/trending_list_loading.dart';
import 'package:movie_app/features/widgets/trending_list.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'MovieDB Showcase',
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.amber[600],
                      letterSpacing: 1.5,
                      fontFamily: 'Exo',
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                'Popular Movies',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildPopularMovies(context),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                'Top Rated Movies',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildTopRatedMovies(context),
          ],
        ),
      ),
    );
  }

  BlocProvider<TopRatedMoviesBloc> _buildTopRatedMovies(context) {
    return BlocProvider.value(
      value: BlocProvider.of<TopRatedMoviesBloc>(context),
      child: BlocBuilder<TopRatedMoviesBloc, ListState>(
        builder: (ctx, state) {
          if (state is Init) {
            getTopRatedMovies(ctx);
            return TrendingListLoading();
          } else if (state is Empty) {
            return Container();
          } else if (state is Loading) {
            return TrendingListLoading();
          } else if (state is Loaded) {
            final moviesList = (state.list as MovieList).movies;
            return TrendingList(moviesList);
          } else if (state is Error) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }

  BlocProvider<PopularMoviesBloc> _buildPopularMovies(context) {
    return BlocProvider.value(
      value: BlocProvider.of<PopularMoviesBloc>(context),
      child: BlocBuilder<PopularMoviesBloc, ListState>(
        builder: (ctx, state) {
          if (state is Init) {
            getPopularMovies(ctx);
            return LoadingCardSwiper();
          } else if (state is Empty) {
            return Container();
          } else if (state is Loading) {
            return LoadingCardSwiper();
          } else if (state is Loaded) {
            final moviesList = (state.list as MovieList).movies;
            return CardSwiper(movies: moviesList);
          } else if (state is Error) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }

  void getPopularMovies(context) {
    BlocProvider.of<PopularMoviesBloc>(context).add(GetPopularMovies());
  }

  void getTopRatedMovies(context) {
    BlocProvider.of<TopRatedMoviesBloc>(context).add(GetTopRatedMovies());
  }
}
