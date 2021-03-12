import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/bloc/blocs/movie_details_bloc.dart';
import 'package:movie_app/features/bloc/blocs/popular_movies_bloc.dart';
import 'package:movie_app/features/bloc/blocs/top_rated_movies_bloc.dart';
import 'package:movie_app/features/pages/home.dart';
import 'package:movie_app/features/pages/movie_details.dart';
import 'package:movie_app/injection_container.dart' as injectionContainer;
import 'package:movie_app/core/network/http_override.dart';

import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new HttpOverride();
  await injectionContainer.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMoviesBloc>(
            create: (context) => singleton<PopularMoviesBloc>()),
        BlocProvider<MovieDetailsBloc>(
            create: (context) => singleton<MovieDetailsBloc>()),
        BlocProvider<TopRatedMoviesBloc>(
            create: (context) => singleton<TopRatedMoviesBloc>()),
      ],
      child: MaterialApp(
        title: 'MovieDB',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
        routes: {
          Home.routeName: (ctx) => Home(),
          MovieDetails.routeName: (ctx) => MovieDetails(),
        },
      ),
    );
  }
}
