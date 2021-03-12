import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/core/network/movie_db_client.dart';
import 'package:movie_app/features/domain/entities/movie.dart';
import 'package:movie_app/features/domain/entities/movie_list.dart';
import 'package:http/http.dart' as http;

abstract class MoviesRemoteDatasource {
  Future<MovieList> getPopularMovies();
  Future<MovieList> getTopRatedMovies();
  Future<Movie> getMovieDetails(int movieId);
}

class MoviesRemoteDatasourceImplementation extends MovieDbClient
    implements MoviesRemoteDatasource {
  final http.Client client;

  MoviesRemoteDatasourceImplementation({@required this.client});

  @override
  Future<MovieList> getPopularMovies() =>
      _getPopularMoviesFromUrl('${MovieDbClient.host}/movie/popular');

  @override
  Future<Movie> getMovieDetails(int movieId) =>
      _getMovieDetailsFromUrl('${MovieDbClient.host}/movie/$movieId');

  Future<MovieList> _getPopularMoviesFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer ${MovieDbClient.api_key}'
      },
    );

    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<Movie> _getMovieDetailsFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer ${MovieDbClient.api_key}'
      },
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieList> getTopRatedMovies() =>
      _getTopRatedMovies('${MovieDbClient.host}/movie/top_rated');

  Future<MovieList> _getTopRatedMovies(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer ${MovieDbClient.api_key}'
      },
    );

    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
